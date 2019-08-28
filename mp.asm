; PROGRAM :: ASSEMBLY LANGUAGE PROGRAM TO SEARCH A KEY ELEMENT IN A
;            LIST OF 'n' NUMBER USING THE BINARY SEARCH ALGORITHM

.MODEL SMALL

; MACRO TO DISPLAY THE MESSAGE....
DISPLAY1 MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM

.DATA

LIST DB 0H, 3H , 4H , 5H , 7H , 8H
NUMBER EQU ($-LIST)
KEY DB 3H             
MSG1 DB 0DH, 0AH, "ELEMENT FOUND IN THE LIST...$"
MSG2 DB 0DH, 0AH, "SEARCH FAILED !! ELEMENT NOT FOUND IN THE LIST $"


.CODE

START : MOV AX, @DATA
        MOV DS, AX
        MOV CH, NUMBER-1        ; HIGH VALUE...
        MOV CL, 00H             ; LOW VALUE...

AGAIN:  MOV SI, OFFSET LIST
        XOR AX, AX
        CMP CL, CH
        JE NEXT
        JNC FAILED

NEXT:   MOV AL, CL
        ADD AL, CH
        SHR AL, 01H             ; DIVIDE BY 2
        MOV BL, AL
        XOR AH, AH              ; CLEAR AH
        MOV BP, AX
        MOV AL, DS:[BP][SI]
        CMP AL, KEY             ; COMPARE KEY AND A[i]        
        JE SUCCESS              ; IF EQUAL, DISPLAY SUCCESS MESSAGE
        JC INCLOW
        MOV CH, BL              ; IF KEY>A[i]  SHIFT HIGH        
        DEC CH
        JMP AGAIN

INCLOW: MOV CL, BL              ; IF KEY<A[i]  SHIFT LOW
        INC CL
        JMP AGAIN

SUCCESS:mov al,key
        add al,30h
        mov dl,al
        mov ah,02h
        int 21h
        DISPLAY1 MSG1
        jmp final

failed: mov al,key
        add al,30h
        mov dl,al
        mov ah,02h
        int 21h
               
        DISPLAY1 MSG2            ; JOB OVER. TERMINATE....
FINAL : mov ah,01h
        int 21h

        MOV AH, 4CH
        INT 21H

END START

