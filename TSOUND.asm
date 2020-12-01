Assume CS: Code, DS: Code
Code SEGMENT
			org 100h
C 			equ 	4900 	; Нота До
Csharp 		equ 	4800 	; Нота До диез
D 			equ 	4700 	; Нота Ре
Dsharp 		equ 	4600 	; Нота Ре диез
E 			equ 	4500	; Нота Ми
F 			equ 	4400	; Нота Фа
Fsharp 		equ 	4300	; Нота Фа диез
G 			equ 	4200	; Нота Соль
Gsharp 		equ 	4100	; Нота Соль диез
A 			equ 	4000	; Нота Ля
Asharp 		equ 	3900	; Нота Ля диез
H 			equ 	3800	; Нота Си

number_cycles 	equ 	100 ; Количество циклов (длит.)
port_b 			equ 	61h ; Адрес системного порта В
				.286
Start proc near
	mov 	ax,cs
	mov 	ds,ax 			; DS = CS

; Обработка клавиш

beg1: 		call kbin 		; Опрос клавиатуры
	cmp 	al,'z' 			; = z ?
	jnz beg2 				; Нет
	call ton1				; Звук ноты C
	jmp beg1 				; Переход на начало цикла
beg2:	
	cmp	al,'s'				; = s ?
	jnz	beg3  				; Нет
	call ton2 				; Звук ноты Csharp
	jmp beg1  				;
beg3: 	
	cmp	al,'x' 				; = x ?
	jnz	beg4 				; Нет
	call ton3 				; Звук ноты D
	jmp beg1 				;
beg4: 	
	cmp	al,'d' 				; = d ?
	jnz	beg5 				; Нет
	call ton4 				; Звук ноты  Dsharp
	jmp beg1 				;
beg5: 	
	cmp	al,'c' 				; = c ?
	jnz	beg6 				; Нет
	call ton5 				; Звук ноты E
	jmp beg1 				;
beg6: 	
	cmp	al,'v' 				; = v ?
	jnz	beg7 				; Нет
	call ton6 				; Звук ноты F
	jmp beg1 				;
beg7: 
	cmp	al,'g' 				; = g ?
	jnz	beg8 				; Нет
	call ton7 				; Звук ноты Fsharp
	jmp beg1 				;
beg8: 
	cmp	al,'b' 				; = b ?
	jnz	beg9 				; Нет
	call ton8 				; Звук ноты G
	jmp beg1 				;
beg9: 
	cmp	al,'h' 				; = h ?
	jnz	beg10 				; Нет
	call ton9 				; Звук ноты Gsharp
	jmp beg1 				;
beg10: 
	cmp	al,'n' 				; = n ?
	jnz	beg11 				; Нет
	call ton10 				; Звук ноты A
	jmp beg1 				;
beg11:
	cmp	al,'j' 				; = j ?
	jnz	beg12 				; Нет
	call ton11 				; Звук ноты Asharp
	jmp beg1 				;
beg12:
	cmp	al,'m' 				; = m ?
	jnz	begend 				; Нет
	call ton12 				; Звук ноты H
	jmp beg1 				;
begend: cmp al,'q' 			; = 'q' ?
	jnz beg1 				; Нет
	int 20h 				; Выход из программы 
start endp		

; Воспроизведение звука

ton12 proc near				
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, H				; Нота Си
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton11 proc near				
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, Asharp			; Нота Ля диез
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton10 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, A				; Нота Ля
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton9 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, Gsharp			; Нота Соль диез
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton8 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di,	G				; Нота Соль
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton7 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, Fsharp			; Нота Фа диез
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton6 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, F				; Нота Фа
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton5 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, E				; Нота Ми
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton4 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, Dsharp			; Нота Ре диез
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton3 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, D				; Нота Ре
	jmp ton0				; Переход на универсальную процедуру генерации звука	
ton2 proc near
	mov dx,number_cycles	; Количество времени на Воспроизведение
	mov di, Csharp			; Нота До диез
	jmp ton0				; Переход на универсальную процедуру генерации звука
ton1 proc near 				
	mov dx,number_cycles 	; Длительность
	mov di,	C 				; Нота До

; Универсальная процедура генерации звука
; DX – количество циклов, DI – задержка

ton0 proc near
	cli 					; Запрещение прерываний
	in al,port_b 			; Чтение сост. системн. порта В
	and al,11111110b 		; Отк. динамика от таймера

ton01:	or al,00000010b 	; Включение динамика
	out port_b,al 			; Запись в системный порт В
	mov cx,di 				; Счетчик цикла задержки
	loop $ 					; Задержка
; Выключение звука
	and al,11111101b 		; Выключение динамика
	out port_b,al 			; Запись в системный порт В
	mov cx,di 				; Счетчик цикла задержки
	loop $ 					; Задержка
	dec dx 					; Декремент счетчика колич. циклов
	jnz ton01 				; Переход на начало нового периода
	sti 					; Разрешение прерываний
	ret 					; Выход из процедуры

ton0 endp 					; Конец универсальной процедуры
ton1 endp 					;
ton2 endp 					;
ton3 endp					;
ton4 endp					;
ton5 endp					;
ton6 endp					;
ton7 endp					;
ton8 endp					;
ton9 endp					;
ton10 endp					;
ton11 endp					;
ton12 endp					;

kbin proc near 				; Ввод с клавиатуры с ожиданием
	mov ah,0 				; Функция 0
	int 16h 				; клавиатурного прерывания
	ret 					; Выход из процедуры
kbin endp 					; Конец процедуры ввода с клавиатуры


code ends 					; Конец сегмента (кодового)
	END Start 				; Указание на точку входа