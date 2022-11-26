// Correction for modern compiler, + Addition for Auto exe fixup and header sign - by Orion_ [2013]
// Updated by Kneesnap to fix crashing when there are too many sections in a CPE file. (2022)


#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
	char id[8];		/* 0x00 */
	long text;		/* 0x08 */
	long data;		/* 0x0c */
	long pc0;		/* 0x10 */
	long gp0;		/* 0x14 */
	long t_addr;		/* 0x18 */
	long t_size;		/* 0x1c */
	long d_addr;		/* 0x20 */
	long d_size;		/* 0x24 */
	long b_addr;		/* 0x28 */
	long b_size;		/* 0x2c */
	long s_addr;		/* 0x30 */
	long s_size;		/* 0x34 */
	long SavedSP;	/* 0x38 */
	long SavedFP;	/* 0x3c */
	long SavedGP;	/* 0x40 */
	long SavedRA;	/* 0x44 */
	long SavedS0;	/* 0x48 */
} e_header;

typedef struct mylist {
	long base, size;
	long fofs;
	mylist *next;
} MYLIST;

#define HEADER_SIZE 2048

e_header head;

char	sign[] = "Sony Computer Entertainment Inc. for Japan area";	// ADDED

int	main(int argc, char* argv[])
{
	FILE* filein, * fileout;
	char id;
	long base, size, least, pc;
	char* buffer;
	MYLIST* root = NULL;
	MYLIST* last = NULL;
	MYLIST* temp;
	int count, index;
	unsigned int nsize;
	char psx[16];
	char flname[256];	// ADDED

	if (argc <= 1) {
		printf("Usage: cpe2exe <file.cpe> [default_stack]\n");
		printf("Example: cpe2exe frogger.cpe 0x801fff00\n");
		exit(1);
	}

	// Open file.
	filein = fopen(argv[1], "rb");
	if (filein == NULL) {
		perror("fopen");
		exit(-1);
	}
	
	fread(psx, 6, 1, filein);
	if (psx[0] != 'C' || psx[1] != 'P' || psx[2] != 'E') {
		fclose(filein);
		printf("Not a CPE file.\n");
		exit(-1);
	}

	// Default stack.
	long default_stack = 0x801ffff0;
	if (argc >= 2) {
		char* startPtr = (argv[2][1] == 'x' ? &argv[2][2] : argv[2]);
		default_stack = (long)strtoul(startPtr, &startPtr + strlen(startPtr), 16);
		if (!default_stack) {
			printf("Invalid stack offset '%s'.\n", argv[2]);
			exit(-1);
		}
	}
	printf("Using default stack offset of %08x.\n", default_stack);

	// Start reading.
	count = pc = 0;
	fread(&id, 1, 1, filein);
	while (id != 0) {
		switch (id) {
		case 3:
			fread(&pc, 2, 1, filein); /* skip unknown (to me) field */
			fread(&pc, 4, 1, filein);
			printf("Program Counter = 0x%08x\n", pc);
			break;
		case 1:
			fread(&base, 4, 1, filein);
			fread(&size, 4, 1, filein);

			temp = (MYLIST*)malloc(sizeof(MYLIST));
			temp->base = base;
			temp->size = size;
			temp->fofs = ftell(filein);
			temp->next = NULL;

			if (count++ > 0) {
				last->next = temp;
			} else {
				root = temp;
			}
			last = temp;

			printf("Entry #%04d Base Address = 0x%08x Size = 0x%08x(%d)\n",
				count, base, size, size);
			fseek(filein, size, SEEK_CUR);
			break;
		default:
			printf("Unknown id field 0x%02x at offset 0x%08x",
				ftell(filein) - 1, 0);
		}
		fread(&id, 1, 1, filein);
	}
	printf("Read %d sections.\n", count);

	if (count == 0) {
		printf("There are no sections to convert..?\n");
		return 1;
	}

	// Start writing to output.

	temp = root;
	least = root->base;
	while ((temp = temp->next) != NULL)
		if (temp->base < least)
			least = temp->base;
	strcpy(flname, argv[1]);	// ADDED
	strcpy(strstr(flname, ".cpe"), ".exe");	// ADDED

	//fileout = fopen(argv[2] , "wb");
	fileout = fopen(flname, "wb");	// MODIFIED
	if (fileout == NULL) {
		perror("fopen(create)");
		exit(-1);
	}

	// Write data.
	printf("Writing section to output file...\n");
	temp = root;
	for (index = 0; index < count; index++) {
		fseek(filein, root->fofs, SEEK_SET);
		buffer = (char*)malloc(root->size);
		fread(buffer, root->size, 1, filein);
		fseek(fileout, root->base - least + HEADER_SIZE, SEEK_SET);
		fwrite(buffer, root->size, 1, fileout);
		free(buffer);
		temp = root;
		root = root->next;
		free(temp);
	}

	memset(&head, 0, sizeof(e_header));
	strcpy(head.id, "PS-X EXE");
	//head.pc = pc == 0 ? least : pc ;
	head.pc0 = pc == 0 ? least : pc;	// CORRECTED
	//head.c_base = least;
	head.t_addr = least;	// CORRECTED
	head.s_addr = default_stack;	// default stack ? ADDED
	fseek(fileout, 0, SEEK_END);

	// ADDED (2048 roundup)
	nsize = ftell(fileout);
	if (nsize & (0x800 - 1))	// not exact 2048
	{
		int	iop, klm;
		char	dummy = 0;

		klm = nsize;
		nsize += 0x800;
		nsize &= 0xFFFFF800;

		for (iop = klm; iop < nsize; iop++)
			fwrite(&dummy, 1, 1, fileout);
	}

	head.t_size = ftell(fileout) - HEADER_SIZE;
	fseek(fileout, 0, SEEK_SET);
	buffer = (char*)malloc(HEADER_SIZE);
	memset(buffer, 0, HEADER_SIZE);
	memcpy(buffer, &head, sizeof(e_header));
	memcpy(&buffer[0x4C], sign, sizeof(sign));	// ADDED
	fwrite(buffer, HEADER_SIZE, 1, fileout);
	fclose(fileout);
	fclose(filein);
	printf("Success.\n");
	return (0);
}
