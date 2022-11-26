/************************************************************************************
	ISL PSX LIBRARY	(c) 2000 Interactive Studios Ltd.

	islpoly.h:		Custom polygon types

************************************************************************************/

/*
	The PlayStation's DMA controller has a 16-word FIFO, limiting packet sizes to 16-words
	(including the DMAtag). Otherwise you're free to create packets of any size, containing
	any combination of GPU commands. Here's some flat shaded poly's with transparency control
	(effectively a DR_TPAGE packet, followed by the respective polygon).
*/

// Flat Triangle with ABR control 
typedef struct
{
	u_long	tag;
	u_long	t_code;
	u_char	r0, g0, b0, code;
	short	x0, 	y0;
	short	x1,	y1;
	short	x2,	y2;
} TPOLY_F3;

// Flat Quadrangle with ABR control
typedef struct
{
	u_long	tag;
	u_long	t_code;
	u_char	r0, g0, b0, code;
	short	x0, 	y0;
	short	x1,	y1;
	short	x2,	y2;
	short	x3,	y3;
} TPOLY_F4;

// Gouraud Triangle with ABR control
typedef struct
{
	u_long	tag;
	u_long	t_code;
	u_char	r0, g0, b0, code;
	short	x0, 	y0;
	u_char	r1, g1, b1, pad1;
	short	x1,	y1;
	u_char	r2, g2, b2, pad2;
	short	x2,	y2;
} TPOLY_G3;

// Gouraud Quadrangle with ABR control
typedef struct
{
	u_long	tag;
	u_long	t_code;
	u_char	r0, g0, b0, code;
	short	x0, 	y0;
	u_char	r1, g1, b1, pad1;
	short	x1,	y1;
	u_char	r2, g2, b2, pad2;
	short	x2,	y2;
	u_char	r3, g3, b3, pad3;
	short	x3,	y3;
} TPOLY_G4;

#define	GPUCODE_POLY_F3 		(0x20)
#define	GPUCODE_POLY_F4 		(0x28)
#define	GPUCODE_POLY_G3 		(0x30)
#define	GPUCODE_POLY_G4 		(0x38)

#define	GPUSIZE_POLY_F3 		(4)
#define	GPUSIZE_POLY_F4 		(5)
#define	GPUSIZE_POLY_G3 		(6)
#define	GPUSIZE_POLY_G4 		(8)

#define	GPUSIZE_DR_TPAGE		(1)

#define	GPUSIZE_TPOLY_F3		(GPUSIZE_DR_TPAGE+GPUSIZE_POLY_F3)
#define	GPUSIZE_TPOLY_F4		(GPUSIZE_DR_TPAGE+GPUSIZE_POLY_F4)
#define	GPUSIZE_TPOLY_G3		(GPUSIZE_DR_TPAGE+GPUSIZE_POLY_G3)
#define	GPUSIZE_TPOLY_G4		(GPUSIZE_DR_TPAGE+GPUSIZE_POLY_G4)

#define	setTDrawTPageSize(p,s)	setlen((p), (s)), (p)->t_code = _get_mode(0,1,0)
#define	setTDrawTPage(p)		setTDrawTPageSize((p), 1)

#define	setTPolyF3(p)			setTDrawTPageSize((p), GPUSIZE_TPOLY_F3), ((p)->code)=GPUCODE_POLY_F3
#define	setTPolyF4(p)			setTDrawTPageSize((p), GPUSIZE_TPOLY_F4), ((p)->code)=GPUCODE_POLY_F4
#define	setTPolyG3(p)			setTDrawTPageSize((p), GPUSIZE_TPOLY_G3), ((p)->code)=GPUCODE_POLY_G3
#define	setTPolyG4(p)			setTDrawTPageSize((p), GPUSIZE_TPOLY_G4), ((p)->code)=GPUCODE_POLY_G4

