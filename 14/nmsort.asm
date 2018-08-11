;		page	60,132
title	NmSort	(exe) ���� � ���஢�� ����
;-------------------------------------------------------------
stack	segment	para stack 'stack'
		dw		32 dup(?)
stack	ends
;-------------------------------------------------------------
datasg	segment	para 'data'
namepar	label	byte
maxnlen	db		21
namelen	db		?
namefld	db		21 dup(' ')
crlf	db		13, 10, '$'
endaddr	dw		?
messg1	db		'Name: ', '$'
namectr	db		00
nametab	db		30 dup(20 dup(' '))
namesav	db		20 dup(?), 13, 10, '$'
swapped	db		00
datasg	ends
;-----------------------------------------------------------
codesg	segment	para 'code'
begin	proc	far
		assume	cs:codesg, ds:datasg, ss:stack, es:datasg
		push	ds
		xor		ax,ax
		push	ax
		mov		ax,datasg
		mov		ds,ax
		mov		es,ax

		cld
		mov		di,offset nametab
		call	q10clr
		call	q20curs
a20loop:	
		call	b10read			; ����� ��� � ����������
		cmp		namelen,00		; ��� �������?
		jz		a30				;	��� - ��� �� ���஢��
		cmp		namectr,30		; ������� 30 ����?
		je		a30				; ��� �� ���஢��
		call	d10stor			; ������� ��� � ⠡����
		jmp		a20loop
a30:
		call	q10clr
		call	q20curs
		cmp		namectr,01		; ����� 2 ����?
		jbe		a40				;	�� - ���
		call	g10sort			; ����஢��� �����
		call	k10disp			; �뢥�� १����
a40:
		ret
begin	endp
;				���� ���� � ����������:
;				--------------------------------------------
b10read	proc	near
		mov		ah,09			; �뢥�� ⥪�� �����
		mov		dx,offset messg1
		int		21h
		mov		ah,0ah			; ����� ���
		mov		dx,offset namepar
		int		21h
		mov		ah,09
		mov		dx,offset crlf	; �뢥�� ��७�� ��ப�
		int		21h
		mov		bh,00
		mov 	bl,namelen
		mov		cx,21
		sub		cx,bx			; ���᫨�� ��⠢����� ����
b20:
		mov		namefld[bx],20h	;	� ��������� �� �஡�����
		inc		bx
		loop	b20
		ret
b10read	endp
;				������ ����� � ⠡����:
;				--------------------------------------------
d10stor	proc	near
		inc		namectr
		cld
		mov		si,offset namefld
		mov		cx,10
		rep		movsw
		ret
d10stor	endp
;				����஢�� ���� � ⠡���:
;				--------------------------------------------
g10sort	proc	near
		sub		di,40			; ��⠭����� ���� ��⠭���
		mov		endaddr,di
g20:
		mov		swapped,00		; ��⠭����� ��砫�
		mov		si,offset nametab	;⠡����
g30:
		mov		cx,20			; ����� �ࠢ�����
		mov		di,si
		add		di,20			; ������饥 ���
		mov		ax,di			; ���࠭��� ����
		mov		bx,si
		repe cmpsb				; ��. [si] ����� �. [di]?
		jbe		g40				;	�� - ��� ����⠭����
		call	h10xchg			;	��� - ����⠭����
g40:
		mov		si,ax			; ���� ᫥���饣� �����
		cmp		si,endaddr		; ����� ⠡����?
		jbe		g30				;	��� - �த������
		cmp		swapped,00		; ���� ����⠭����?
		jnz		g20				; �� - �த������
		ret						; ��� - �����
g10sort	endp
;				����⠭���� ����⮢ ⠡����:
;				--------------------------------------------
h10xchg	proc	near
		mov		cx,10
		mov		di,offset namesav
		mov		si,bx
		rep movsw				; ���࠭��� ���孨� �����.
		mov		cx,10
		mov		di,bx			; ���᫠�� ������ �����
		rep movsw				;	�� ���� ���孥��
		mov		cx,10
		mov		si,offset namesav
		rep movsw
		mov		swapped,01		; �ਧ��� ����⠭����
		ret
h10xchg	endp
;				�뢮� �� �࠭ �����஢����� ����:
;				--------------------------------------------
k10disp	proc	near
		mov		si,offset nametab
k20:
		mov		di,offset namesav
		mov		cx,10
		rep movsw
		mov		ah,09
		mov		dx,offset namesav
		int		21h
		dec		namectr
		jnz		k20
		ret
k10disp	endp
;				���⪠ �࠭�:
;				--------------------------------------------
q10clr	proc	near
		mov		ax,0600h
		mov		bh,07h
		sub		cx,cx
		mov		dx,184fh
		int		10h
		ret
q10clr	endp
;				��⠭���� �����:
;				--------------------------------------------
q20curs	proc	near
		mov		ah,02
		sub		bh,bh
		sub		dx,dx
		int		10h
		ret
q20curs	endp
codesg	ends
		end		begin