;
; Practica_3.asm
;
; Created: 12/03/2020 04:38:13 p. m.
; Author : U-Lee
;


.EQU FIN_RAM = 0x21FF

	.DEF estado=R16
	.DEF push_button=R20


	.CSEG
	.ORG 0x0000
PRINCIPAL:
	; 0. Inicializa la pila con el último valor de la memoria

	LDI R17, LOW(FIN_RAM)
	OUT SPL, R17
	LDI R17, HIGH(FIN_RAM)
	OUT SPH, R17

	; 1. Se configura el puerto PORTAA como salida
	LDI R17, 0xFF
	OUT DDRA, R17	;Se configura el registro de la dicrección del puerto A como salida
	
	; 2. Se configura el bit-0 del puerto PORTC como entrada.
	CBI DDRC, 0		;Apaga el bit-0 del registro de dirección del puerto c (DDRC) bit-0 Se configura como salida.
	
	; 3. Se inicializa el estado a cero cuando <= 0
	LDI estado, 0
	
	;4. LLammar a subrutina EncenderDisplay(estado).
	CALL EncenderDisplay
	
LEER_PUSH_BUTTON:
	; 5. Lee el estado del push-button
	IN push_button, PINC	; Lee el valor del puerto C y lo almacena en push_button.
	ANDI push_button, 1		; Apaga todos los bits, excepto el bit-0
	
	;6. Si el estado no está apretado (push_button == 1) salta 5
	CPI push_button, 1		; Hace la comparación (push_button - 1) para encender las banderas en el CREG(registro de estado)
	BREQ LEER_PUSH_BUTTON	; Salta a donde está la etiqueta LEER_PUSH_BUTTON si al anterior comparación es igual   
	
	;7. estado <= estado + 1
	INC estado
	
	;8. Si estado < 10 salta a 10
	CPI estado, 10		;Compara(estado - 10)
	BRLT FIN_SI			;Si estado < 10 salta añ fin_si
	
	;9. estado <= 0
	LDI estado, 0
	
FIN_SI:
	;10. LLammar a EncenderDisplay(estado)
	CALL EncenderDisplay
	
	;11. Saltar a 5
	RJMP LEER_PUSH_BUTTON
	
	.INCLUDE "Display7Seg.asm" 

