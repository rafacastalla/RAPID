MODULE MainModule
    
    CONST robtarget POS_ORIGEN :=[[515,0,712],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_AGARRE := [[485,-577,395],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_AGARRELIBRE := [[330,-422,570],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_EMPAQUETADOLIBRE := [[375,-200,430],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_EMPAQUETADO := [[375,-200,245],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget POS_EMPAQUETADOAPROX := [[375,-200,595],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
     
    PROC main()
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
        MoveJ POS_EMPAQUETADOAPROX, v40, z100, tool0;
        MoveL POS_EMPAQUETADOLIBRE, v30, fine, tool0;
        MoveL POS_EMPAQUETADO, v20, fine, tool0;
        SetDO GRIPPER_CLOSE, 1;
        WaitTime 0.3;
        MoveL POS_EMPAQUETADOLIBRE, v20, fine, tool0;
        MoveJ POS_ORIGEN, v40, z100, tool0;
    ENDPROC
ENDMODULE