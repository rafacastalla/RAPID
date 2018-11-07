MODULE MainModule
    
    CONST robtarget POS_ORIGEN :=[[515,0,712],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_AGARRE := [[485,-577,395],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_AGARRELIBRE := [[330,-422,570],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_EMPAQUETADOLIBRE := [[375,-200,430],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_EMPAQUETADO := [[375,-200,245],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_EMPAQUETADOAPROX := [[375,-200,595],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_DESECHOLIBRE := [[500,-200,515],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_DESECHO := [[500,-200,245],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR intnum NUMLATASNOK := 0;
    VAR intnum SEPARACION := 90;
    VAR intnum ALTURA := 65;
    VAR intnum NUMLATAS := 0;
    VAR intnum NIVEL := 0;
    
    PROC main()
        WHILE NUMLATAS < 3 DO
            SingArea\Wrist;
            !Path_10;
            MoveJ POS_ORIGEN, v40, z100, tool0;
            SetDO CONVEYOR_FWD, 1;
            WaitDI CONVEYOR_OBJ_SEN, 1;
            SetDO CONVEYOR_FWD, 0;
            MoveL POS_AGARRELIBRE, v40, z100, tool0;
            MoveL POS_AGARRE, v20, fine, tool0;
            SetDO GRIPPER_CLOSE, 0;
            WaitTime 0.3;
            MoveL POS_AGARRELIBRE, v20, fine, tool0;
            
            WHILE (DInput(LATA_OK)) = 0 AND DInput(LATA_NOK) = 0 DO
                
            ENDWHILE
            
            IF LATA_OK = 1 THEN
                MoveJ POS_EMPAQUETADOAPROX, v40, z100, tool0;
                MoveL Offs(POS_EMPAQUETADOLIBRE,0,SEPARACION * NUMLATAS, ALTURA*NIVEL), v30, fine, tool0;
                MoveL Offs(POS_EMPAQUETADO,0,SEPARACION * NUMLATAS, ALTURA*NIVEL), v20, fine, tool0;
                SetDO GRIPPER_CLOSE, 1;
                WaitTime 0.3;
                MoveL POS_EMPAQUETADOLIBRE, v20, fine, tool0;
                MoveJ POS_ORIGEN, v40, z100, tool0;
                NUMLATAS := NUMLATAS + 1;
                IF NUMLATAS = 3 THEN
                    NUMLATAS := 0;
                    NIVEL := 1;
                ENDIF
            ELSE
                MoveJ POS_EMPAQUETADOAPROX, v40, z100, tool0;
                MoveL Offs(POS_DESECHOLIBRE,0,SEPARACION * NUMLATASNOK, 0), v40, fine, tool0;
                MoveL Offs(POS_DESECHO,0,SEPARACION * NUMLATASNOK, 0), v20, fine, tool0;
                SetDO GRIPPER_CLOSE, 1;
                WaitTime 0.3;
                MoveL POS_DESECHOLIBRE, v20, fine, tool0;
                MoveJ POS_ORIGEN, v40, z100, tool0;
                NUMLATASNOK := NUMLATASNOK + 1;
            ENDIF
        ENDWHILE
    ENDPROC
ENDMODULE