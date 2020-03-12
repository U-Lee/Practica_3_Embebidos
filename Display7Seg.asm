/*
 * Display7Seg.asm
 *
 *  Created: 12/03/2020 05:03:56 p. m.
 *   Author: U-Lee
 */ 
 	.CSEG
	;Define la tabla en la memorio flash

dirLEDs: .DB 0x3F, 0x0C, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0xC7

EncenderDisplay:
	; Guarda los registros que utiliza la subrutina en la pila 
	PUSH ZL
	PUSH ZH
	PUSH R0

	;Inicializa el apuntador Z con la dirección de mnemoria flash donde está la tabla.
	LDI ZL, LOW(dirLEDs<<1)		;Inicializa el apuntador Z con la dirección de la tabla
	LDI ZH, HIGH(dirLEDs<<1)

	;Se desplaza la cantidad de bits que indique R16
	CLR R0		; R0 <= 0
	ADD ZL, R16
	ADC ZH, R0	; Se puede omitir

	LPM R0, Z	; Carga el contenido de la dirección de memoria apuntada por z a R0 (R0 <= *(Z))

	; Envía el dato al puerto A
	OUT PORTA, R0

	; Restaura los registros desde la pila
	POP R0
	POP ZH
	POP ZL
	RET		; Registro de subrutina
