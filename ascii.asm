.model small
.data

MSG1 db 0dh,0ah,"Enter alpha-numeric charcter: $"
RES db 02 dup(0)

.code
MOV AX,@DATA
MOV DS,AX
LEA DX,MSG1
CALL DISP
MOV AH,01H
INT 21H
MOV BL,AL
MOV CL,4
SHR AL,CL
CMP AL,0AH
JC DIGIT
ADD AL,07

DIGIT: ADD AL,30H
       MOV RES,AL
       AND BL,0FH
       CMP BL,0AH
       JC DIGIT1
;       ADD AL,07

DIGIT1: ADD BL,30H
        MOV RES+1,BL
        MOV AH,00H
        MOV AL,03H
        INT 10H
        MOV AH,02H
        MOV BH,00H
        MOV DH,0CH
        MOV DL,28H
        INT 10H
        MOV RES+2,'$'
        LEA DX,RES
        CALL DISP
        MOV AH,4CH
        INT 21H

DISP PROC NEAR
 MOV AH,09H
 INT 21H
 RET
 DISP ENDP
 END

