		page	60,132
		TITLE	PALITRA (EXE) ;����� �������
;-------------------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;-------------------------------------------------------
CODESG  SEGMENT PARA 'Code'
BEGIN   PROC    FAR
		ASSUME  CS:CODESG,DS:NOTHING,SS:STACKSG,ES:NOTHING
        PUSH    DS
		SUB     AX,AX
        PUSH    AX
;		MOV		AX,DATASG
;		MOV		DS,AX
;		MOV		ES,AX

		MOV		AH,0BH		; ������� ��������� �������
		MOV		BH,01		; ������� �������
		MOV		BL,00
		INT		10H
		
		RET
BEGIN	ENDP
CODESG  ENDS
		END BEGIN