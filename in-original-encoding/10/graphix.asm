		page	60,132
		TITLE	GRAPHIX (EXE) ; ������ ����� � �������
;-------------------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;-------------------------------------------------------
CODESG  SEGMENT PARA 'Code'
MAIN	   PROC    FAR
		ASSUME  CS:CODESG,DS:NOTHING,SS:STACKSG,ES:NOTHING
        PUSH    DS
		SUB     AX,AX
        PUSH    AX

		MOV		AH,00		; ��������� ������ �������
		MOV		AL,0EH		; �����
		INT		10H
		MOV		AH,0BH		; ��������� �������
		MOV		BH,00		; ���
		MOV		BL,00		; ����
		INT		10H
		MOV		BX,00		; ��������� ����,
		MOV		CX,00		;  �������
		MOV		DX,00		;  � ������
A50:	
		MOV		AH,0CH		; ������� ������ �����
		MOV		AL,BL		; ���������� ����
		INT		10H			; BX, CX, DX �����������
		INC		CX
		CMP		CX,320
		JNE		A50
		MOV		CX,00
		INC		BL
		INC		DX
		CMP		DX,40
		JNE		A50
		RET
MAIN	ENDP
CODESG  ENDS
		END MAIN