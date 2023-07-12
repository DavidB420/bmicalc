use32

org 50000h
%include 'nxapi.inc'

mov esi,windowTitle
call sys_setupScreen

call drawFirstScreen

call sys_getoldlocation

mainLoop:
mov dword [mouseaddress],lbuttonclick
mov dword [keybaddress],sys_windowloop
mov dword [bgtaskaddress],sys_nobgtasks
jmp sys_windowloop

doneprog:
ret

windowTitle db 'BMI Calculator',0
heightInchesStr db 'Height in inches',0
weightPoundsStr db 'Weight in pounds',0
bmiCalcStr db 'Calculate BMI',0
currentSelection db 0
heightNumX dw 210
weightNumX dw 210

drawFirstScreen:
mov esi,heightInchesStr
mov word [X],100
mov word [Y],100
mov word [Color],0
call sys_printString
mov esi,weightPoundsStr
mov word [X],100
mov word [Y],200
mov word [Color],0
call sys_printString
mov ax,250
mov bx,300
mov cx,400
mov dx,350
call sys_drawbox
mov byte [buttonornot],1
mov word [Color],0
mov ax,200
mov bx,90
mov cx,450
mov dx,120
call sys_drawbox
mov ax,200
mov bx,190
mov cx,450
mov dx,220
call sys_drawbox
mov word [Color],0xffff
mov ax,205
mov bx,95
mov cx,445
mov dx,115
call sys_drawbox
mov ax,205
mov bx,195
mov cx,445
mov dx,215
call sys_drawbox
mov byte [buttonornot],0
mov esi,bmiCalcStr
mov word [X],285
mov word [Y],320
mov word [Color],0
call sys_printString
ret

lbuttonclick:
cmp word [mouseX],619
jle s1
cmp word [mouseX],636
jg s1
cmp word [mouseY],1
jle s1
cmp word [mouseY],13
jg s1
jmp doneprog
s1:
cmp word [mouseX],199
jle s2
cmp word [mouseX],450
jg s2
cmp word [mouseY],94
jle s2
cmp word [mouseY],120
jg s2
call getheight
s2:
cmp word [mouseX],199
jle s3
cmp word [mouseX],450
jg s3
cmp word [mouseY],194
jle s3
cmp word [mouseY],220
jg s3
call getweight
s3:
jmp mainLoop

getheight:
cmp byte [currentSelection],1
je donegetheight
mov byte [currentSelection],1
getheightLoop:
mov dword [mouseaddress],lbuttonclick
mov dword [keybaddress],keybinput
mov dword [bgtaskaddress],sys_nobgtasks
jmp sys_windowloop
donegetheight:
ret

getweight:
cmp byte [currentSelection],2
je donegetweight
mov byte [currentSelection],2
getWeightLoop:
mov dword [mouseaddress],lbuttonclick
mov dword [keybaddress],keybinput
mov dword [bgtaskaddress],sys_nobgtasks
jmp sys_windowloop
donegetweight:
ret

keybinput:
cmp al,'1'
jne key1
mov dl,'1'
call addnumber
jmp getheightLoop
key1:
cmp al,'2'
jne key2
mov dl,'2'
call addnumber
jmp getheightLoop
key2:
cmp al,'3'
jne key3
mov dl,'3'
call addnumber
jmp getheightLoop
key3:
cmp al,'4'
jne key4
mov dl,'4'
call addnumber
jmp getheightLoop
key4:
cmp al,'5'
jne key5
mov dl,'5'
call addnumber
jmp getheightLoop
key5:
cmp al,'6'
jne key6
mov dl,'6'
call addnumber
jmp getheightLoop
key6:
cmp al,'7'
jne key7
mov dl,'7'
call addnumber
jmp getheightLoop
key7:
cmp al,'8'
jne key8
mov dl,'8'
call addnumber
jmp getheightLoop
key8:
cmp al,'9'
jne key9
mov dl,'9'
call addnumber
jmp getheightLoop
key9:
ret

addnumber:
pusha
cmp byte [currentSelection],1
jne skipheightAdd
mov bx,word [heightNumX]
mov cx,100
jmp skipweightAdd
skipheightAdd:
mov bx,word [weightNumX]
mov cx,200
skipweightAdd:
mov word [Color],0
mov word [X],bx
mov word [Y],cx
call sys_printChar
add bx,5
mov word [heightNumX],bx
popa
ret