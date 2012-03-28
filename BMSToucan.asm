
_main:

;BMSToucan.c,94 :: 		void main() {
;BMSToucan.c,96 :: 		setup();
	CALL        _setup+0, 0
;BMSToucan.c,99 :: 		for(;;)
L_main0:
;BMSToucan.c,103 :: 		reset_candata();
	CALL        _reset_candata+0, 0
;BMSToucan.c,106 :: 		if (flag_ovp == 0x01) {
	MOVF        _flag_ovp+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;BMSToucan.c,108 :: 		CAN_data[BMS_ERROR_BIT].B0 = 1;
	BSF         _CAN_data+6, 0 
;BMSToucan.c,109 :: 		}
L_main3:
;BMSToucan.c,110 :: 		if (flag_lvp = 0x01) {
	MOVLW       1
	MOVWF       _flag_lvp+0 
	MOVF        _flag_lvp+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;BMSToucan.c,112 :: 		CAN_data[BMS_ERROR_BIT].B1 = 1;
	BSF         _CAN_data+6, 1 
;BMSToucan.c,113 :: 		}
L_main4:
;BMSToucan.c,116 :: 		if (flag_check_bms == 0x01) {
	MOVF        _flag_check_bms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;BMSToucan.c,121 :: 		if (BMS_buffer_idx > 0)
	MOVF        _BMS_buffer_idx+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;BMSToucan.c,123 :: 		aborted_bms_checks++;
	INCF        _aborted_bms_checks+0, 1 
;BMSToucan.c,126 :: 		if (aborted_bms_checks > MAX_BMS_CHECK_ABORTS)
	MOVF        _aborted_bms_checks+0, 0 
	SUBLW       10
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;BMSToucan.c,129 :: 		CAN_data[BMS_ERROR_BIT].B2 = 1;
	BSF         _CAN_data+6, 2 
;BMSToucan.c,130 :: 		aborted_bms_checks = 0;
	CLRF        _aborted_bms_checks+0 
;BMSToucan.c,131 :: 		BMS_buffer_idx = 0;
	CLRF        _BMS_buffer_idx+0 
;BMSToucan.c,132 :: 		}
L_main7:
;BMSToucan.c,133 :: 		} else {
	GOTO        L_main8
L_main6:
;BMSToucan.c,134 :: 		aborted_bms_checks = 0; // no checks have been aborted
	CLRF        _aborted_bms_checks+0 
;BMSToucan.c,137 :: 		current_cell++; // move to the next cell
	INFSNZ      _current_cell+0, 1 
	INCF        _current_cell+1, 1 
;BMSToucan.c,138 :: 		if(current_cell >= NUMBER_OF_CELLS)
	MOVLW       128
	XORWF       _current_cell+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVLW       18
	SUBWF       _current_cell+0, 0 
L__main23:
	BTFSS       STATUS+0, 0 
	GOTO        L_main9
;BMSToucan.c,140 :: 		current_cell = 0; // move back to the first cell
	CLRF        _current_cell+0 
	CLRF        _current_cell+1 
;BMSToucan.c,141 :: 		}
L_main9:
;BMSToucan.c,144 :: 		UART1_Write(BMS_QUERY_BIT_1);
	MOVLW       129
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BMSToucan.c,145 :: 		UART1_Write(BMS_QUERY_BIT_2);
	MOVLW       170
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;BMSToucan.c,148 :: 		UART1_Write(CELL_IDS[current_cell]);
	MOVF        _current_cell+0, 0 
	MOVWF       R0 
	MOVF        _current_cell+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _current_cell+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _CELL_IDS+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_CELL_IDS+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_CELL_IDS+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_UART1_Write_data_+0
	CALL        _UART1_Write+0, 0
;BMSToucan.c,149 :: 		UART1_Write(CELL_IDS[current_cell]);
	MOVF        _current_cell+0, 0 
	MOVWF       R0 
	MOVF        _current_cell+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _current_cell+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _CELL_IDS+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_CELL_IDS+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_CELL_IDS+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_UART1_Write_data_+0
	CALL        _UART1_Write+0, 0
;BMSToucan.c,150 :: 		PORTC.B4 = ~PORTC.B4;
	BTG         PORTC+0, 4 
;BMSToucan.c,151 :: 		}
L_main8:
;BMSToucan.c,153 :: 		flag_check_bms = 0x00; // reset the BMS flag
	CLRF        _flag_check_bms+0 
;BMSToucan.c,154 :: 		}
L_main5:
;BMSToucan.c,157 :: 		if(UART1_Data_ready())
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
;BMSToucan.c,160 :: 		BMS_buffer[BMS_buffer_idx] = UART1_read();
	MOVLW       _BMS_buffer+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_BMS_buffer+0)
	MOVWF       FLOC__main+1 
	MOVF        _BMS_buffer_idx+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__main+0, FSR1L
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;BMSToucan.c,161 :: 		BMS_buffer_idx++;
	INCF        _BMS_buffer_idx+0, 1 
;BMSToucan.c,164 :: 		if (BMS_buffer_idx == BMS_QUERY_LENGTH)
	MOVF        _BMS_buffer_idx+0, 0 
	XORLW       29
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;BMSToucan.c,168 :: 		CAN_data[0] = current_cell;
	MOVF        _current_cell+0, 0 
	MOVWF       _CAN_data+0 
;BMSToucan.c,169 :: 		temp = ((BMS_buffer[BMS_V1_B2] << 8) &
	MOVF        _BMS_buffer+4, 0 
	MOVWF       R1 
	CLRF        R0 
;BMSToucan.c,170 :: 		BMS_buffer[BMS_V1_B1]) / 256;
	MOVF        _BMS_buffer+3, 0 
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVF        R3, 0 
	MOVWF       R4 
	CLRF        R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;BMSToucan.c,171 :: 		CAN_data[V1_bit] = temp >> 8;
	MOVF        R5, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R5, 7 
	MOVLW       255
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _CAN_data+1 
;BMSToucan.c,172 :: 		CAN_data[V1_bit+1] = temp & 0x00FF;
	MOVLW       255
	ANDWF       R4, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _CAN_data+2 
;BMSToucan.c,176 :: 		BMS_buffer[BMS_V1_B1]) / 256;
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;BMSToucan.c,177 :: 		CAN_data[V2_bit] = temp >> 8;
	MOVF        R1, 0 
	MOVWF       _CAN_data+2 
;BMSToucan.c,178 :: 		CAN_data[V2_bit+1] = temp & 0x00FF;
	MOVF        R0, 0 
	MOVWF       _CAN_data+3 
;BMSToucan.c,180 :: 		temp = ((BMS_buffer[BMS_V3_B2] << 8) &
	MOVF        _BMS_buffer+12, 0 
	MOVWF       R1 
	CLRF        R0 
;BMSToucan.c,181 :: 		BMS_buffer[BMS_V3_B1]) / 256;
	MOVF        _BMS_buffer+11, 0 
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVF        R3, 0 
	MOVWF       R4 
	CLRF        R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;BMSToucan.c,182 :: 		CAN_data[V3_bit] = temp >> 8;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R5, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _CAN_data+3 
;BMSToucan.c,183 :: 		CAN_data[V3_bit+1] = temp & 0x00FF;
	MOVLW       255
	ANDWF       R4, 0 
	MOVWF       _CAN_data+4 
;BMSToucan.c,185 :: 		temp = ((BMS_buffer[BMS_V4_B2] << 8) &
	MOVF        _BMS_buffer+16, 0 
	MOVWF       R1 
	CLRF        R0 
;BMSToucan.c,186 :: 		BMS_buffer[BMS_V4_B1]) / 256;
	MOVF        _BMS_buffer+15, 0 
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVF        R3, 0 
	MOVWF       R4 
	CLRF        R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;BMSToucan.c,187 :: 		CAN_data[V4_bit] = temp >> 8;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       R5, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _CAN_data+4 
;BMSToucan.c,188 :: 		CAN_data[V4_bit+1] = temp & 0x00FF;
	MOVLW       255
	ANDWF       R4, 0 
	MOVWF       _CAN_data+5 
;BMSToucan.c,190 :: 		flag_send_can = 0x01; // as we have received a full buffer
	MOVLW       1
	MOVWF       _flag_send_can+0 
;BMSToucan.c,192 :: 		}
L_main11:
;BMSToucan.c,193 :: 		}
L_main10:
;BMSToucan.c,196 :: 		if(flag_send_can == 0x01)
	MOVF        _flag_send_can+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;BMSToucan.c,199 :: 		CanWrite(CAN_ADDRESS, CAN_data, 1, SEND_FLAG);
	MOVLW       136
	MOVWF       FARG_CANWrite_id+0 
	MOVLW       0
	MOVWF       FARG_CANWrite_id+1 
	MOVLW       0
	MOVWF       FARG_CANWrite_id+2 
	MOVLW       0
	MOVWF       FARG_CANWrite_id+3 
	MOVLW       _CAN_data+0
	MOVWF       FARG_CANWrite_data_+0 
	MOVLW       hi_addr(_CAN_data+0)
	MOVWF       FARG_CANWrite_data_+1 
	MOVLW       1
	MOVWF       FARG_CANWrite_DataLen+0 
	MOVLW       252
	MOVWF       FARG_CANWrite_CAN_TX_MSG_FLAGS+0 
	CALL        _CANWrite+0, 0
;BMSToucan.c,202 :: 		PORTC.B5 = ~PORTC.B5;
	BTG         PORTC+0, 5 
;BMSToucan.c,205 :: 		BMS_buffer_idx = 0;
	CLRF        _BMS_buffer_idx+0 
;BMSToucan.c,206 :: 		flag_send_can = 0x00;
	CLRF        _flag_send_can+0 
;BMSToucan.c,207 :: 		}
L_main12:
;BMSToucan.c,208 :: 		}
	GOTO        L_main0
;BMSToucan.c,209 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_ISR:

;BMSToucan.c,217 :: 		void ISR() iv 0x0008
;BMSToucan.c,222 :: 		if (INTCON3.INT1IF == 1)
	BTFSS       INTCON3+0, 0 
	GOTO        L_ISR13
;BMSToucan.c,224 :: 		flag_ovp = 0x01;
	MOVLW       1
	MOVWF       _flag_ovp+0 
;BMSToucan.c,225 :: 		INTCON3.INT1IF = 0; // reset the interrupt flag to prevent looping
	BCF         INTCON3+0, 0 
;BMSToucan.c,226 :: 		}
	GOTO        L_ISR14
L_ISR13:
;BMSToucan.c,227 :: 		else if (INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_ISR15
;BMSToucan.c,230 :: 		flag_lvp = 0x01;
	MOVLW       1
	MOVWF       _flag_lvp+0 
;BMSToucan.c,231 :: 		INTCON.INT0IF = 0; // reset the interrupt flag to prevent looping
	BCF         INTCON+0, 1 
;BMSToucan.c,232 :: 		}
	GOTO        L_ISR16
L_ISR15:
;BMSToucan.c,233 :: 		else if (INTCON.TMR0IF == 1)
	BTFSS       INTCON+0, 2 
	GOTO        L_ISR17
;BMSToucan.c,236 :: 		tx_counter++;
	MOVLW       1
	ADDWF       _tx_counter+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tx_counter+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tx_counter+0 
	MOVF        R1, 0 
	MOVWF       _tx_counter+1 
;BMSToucan.c,237 :: 		if(tx_counter > COUNTER_OVERFLOW)
	MOVF        _tx_counter+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__ISR26
	MOVF        _tx_counter+0, 0 
	SUBLW       38
L__ISR26:
	BTFSC       STATUS+0, 0 
	GOTO        L_ISR18
;BMSToucan.c,239 :: 		flag_check_bms = 0x01;
	MOVLW       1
	MOVWF       _flag_check_bms+0 
;BMSToucan.c,240 :: 		tx_counter = 0;
	CLRF        _tx_counter+0 
	CLRF        _tx_counter+1 
;BMSToucan.c,241 :: 		}
L_ISR18:
;BMSToucan.c,242 :: 		INTCON.TMR0IF = 0; // reset the TMR0 interrupt flag
	BCF         INTCON+0, 2 
;BMSToucan.c,243 :: 		}
L_ISR17:
L_ISR16:
L_ISR14:
;BMSToucan.c,244 :: 		}
L_end_ISR:
L__ISR25:
	RETFIE      1
; end of _ISR

_CANbus_setup:

;BMSToucan.c,255 :: 		void CANbus_setup()
;BMSToucan.c,276 :: 		CANInitialize(SJW, BRP, Phase_Seg1, Phase_Seg2, Prop_Seg, init_flag);
	MOVLW       1
	MOVWF       FARG_CANInitialize_SJW+0 
	MOVLW       1
	MOVWF       FARG_CANInitialize_BRP+0 
	MOVLW       6
	MOVWF       FARG_CANInitialize_PHSEG1+0 
	MOVLW       7
	MOVWF       FARG_CANInitialize_PHSEG2+0 
	MOVLW       6
	MOVWF       FARG_CANInitialize_PROPSEG+0 
	MOVLW       185
	MOVWF       FARG_CANInitialize_CAN_CONFIG_FLAGS+0 
	CALL        _CANInitialize+0, 0
;BMSToucan.c,279 :: 		CANSetOperationMode(_CAN_MODE_CONFIG, 0xFF);
	MOVLW       128
	MOVWF       FARG_CANSetOperationMode_mode+0 
	MOVLW       255
	MOVWF       FARG_CANSetOperationMode_WAIT+0 
	CALL        _CANSetOperationMode+0, 0
;BMSToucan.c,282 :: 		mask = -1;
	MOVLW       255
	MOVWF       CANbus_setup_mask_L0+0 
	MOVLW       255
	MOVWF       CANbus_setup_mask_L0+1 
	MOVWF       CANbus_setup_mask_L0+2 
	MOVWF       CANbus_setup_mask_L0+3 
;BMSToucan.c,283 :: 		CANSetMask(_CAN_MASK_B1, mask, _CAN_CONFIG_STD_MSG);
	CLRF        FARG_CANSetMask_CAN_MASK+0 
	MOVLW       255
	MOVWF       FARG_CANSetMask_val+0 
	MOVLW       255
	MOVWF       FARG_CANSetMask_val+1 
	MOVLW       255
	MOVWF       FARG_CANSetMask_val+2 
	MOVLW       255
	MOVWF       FARG_CANSetMask_val+3 
	MOVLW       255
	MOVWF       FARG_CANSetMask_CAN_CONFIG_FLAGS+0 
	CALL        _CANSetMask+0, 0
;BMSToucan.c,286 :: 		CANSetMask(_CAN_MASK_B2, mask, _CAN_CONFIG_STD_MSG);
	MOVLW       1
	MOVWF       FARG_CANSetMask_CAN_MASK+0 
	MOVF        CANbus_setup_mask_L0+0, 0 
	MOVWF       FARG_CANSetMask_val+0 
	MOVF        CANbus_setup_mask_L0+1, 0 
	MOVWF       FARG_CANSetMask_val+1 
	MOVF        CANbus_setup_mask_L0+2, 0 
	MOVWF       FARG_CANSetMask_val+2 
	MOVF        CANbus_setup_mask_L0+3, 0 
	MOVWF       FARG_CANSetMask_val+3 
	MOVLW       255
	MOVWF       FARG_CANSetMask_CAN_CONFIG_FLAGS+0 
	CALL        _CANSetMask+0, 0
;BMSToucan.c,289 :: 		CANSetFilter(_CAN_FILTER_B1_F1,0x202,_CAN_CONFIG_STD_MSG);
	CLRF        FARG_CANSetFilter_CAN_FILTER+0 
	MOVLW       2
	MOVWF       FARG_CANSetFilter_val+0 
	MOVLW       2
	MOVWF       FARG_CANSetFilter_val+1 
	MOVLW       0
	MOVWF       FARG_CANSetFilter_val+2 
	MOVWF       FARG_CANSetFilter_val+3 
	MOVLW       255
	MOVWF       FARG_CANSetFilter_CAN_CONFIG_FLAGS+0 
	CALL        _CANSetFilter+0, 0
;BMSToucan.c,291 :: 		CANSetFilter(_CAN_FILTER_B1_F2,0x50,_CAN_CONFIG_STD_MSG);
	MOVLW       1
	MOVWF       FARG_CANSetFilter_CAN_FILTER+0 
	MOVLW       80
	MOVWF       FARG_CANSetFilter_val+0 
	MOVLW       0
	MOVWF       FARG_CANSetFilter_val+1 
	MOVWF       FARG_CANSetFilter_val+2 
	MOVWF       FARG_CANSetFilter_val+3 
	MOVLW       255
	MOVWF       FARG_CANSetFilter_CAN_CONFIG_FLAGS+0 
	CALL        _CANSetFilter+0, 0
;BMSToucan.c,294 :: 		CANSetOperationMode(_CAN_MODE_NORMAL, 0xFF);
	CLRF        FARG_CANSetOperationMode_mode+0 
	MOVLW       255
	MOVWF       FARG_CANSetOperationMode_WAIT+0 
	CALL        _CANSetOperationMode+0, 0
;BMSToucan.c,295 :: 		} // The CANbus is now set up and ready for use
L_end_CANbus_setup:
	RETURN      0
; end of _CANbus_setup

_reset_candata:

;BMSToucan.c,301 :: 		void reset_candata()
;BMSToucan.c,304 :: 		for (i = 0; i < 8; i++)
	CLRF        R1 
	CLRF        R2 
L_reset_candata19:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__reset_candata29
	MOVLW       8
	SUBWF       R1, 0 
L__reset_candata29:
	BTFSC       STATUS+0, 0 
	GOTO        L_reset_candata20
;BMSToucan.c,306 :: 		CAN_data[i] = 0;
	MOVLW       _CAN_data+0
	ADDWF       R1, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_CAN_data+0)
	ADDWFC      R2, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;BMSToucan.c,304 :: 		for (i = 0; i < 8; i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;BMSToucan.c,307 :: 		}
	GOTO        L_reset_candata19
L_reset_candata20:
;BMSToucan.c,308 :: 		}
L_end_reset_candata:
	RETURN      0
; end of _reset_candata

_setup:

;BMSToucan.c,315 :: 		void setup()
;BMSToucan.c,318 :: 		TRISA = 0; // default PORTA to output
	CLRF        TRISA+0 
;BMSToucan.c,319 :: 		TRISB = 0; // default PORTB to output
	CLRF        TRISB+0 
;BMSToucan.c,320 :: 		TRISC = 0; // default PORTC to output
	CLRF        TRISC+0 
;BMSToucan.c,323 :: 		LATA = 0;
	CLRF        LATA+0 
;BMSToucan.c,324 :: 		LATB = 0;
	CLRF        LATB+0 
;BMSToucan.c,325 :: 		LATC = 0;
	CLRF        LATC+0 
;BMSToucan.c,328 :: 		INTCON.GIE = 1;    // enable global interrupts
	BSF         INTCON+0, 7 
;BMSToucan.c,329 :: 		INTCON.PEIE = 1;   // enable peripheral interrupts
	BSF         INTCON+0, 6 
;BMSToucan.c,330 :: 		INTCON.TMR0IE = 1; // enable timer 0 interrupts to control
	BSF         INTCON+0, 5 
;BMSToucan.c,332 :: 		INTCON2.RBPU = 1;  // disable pull ups on PORTB
	BSF         INTCON2+0, 7 
;BMSToucan.c,333 :: 		INTCON2.INTEDG0 = 1; // interrupt INT0 on rising edge
	BSF         INTCON2+0, 6 
;BMSToucan.c,334 :: 		INTCON2.INTEDG1 = 1; // interrupt INT1 on rising edge
	BSF         INTCON2+0, 5 
;BMSToucan.c,335 :: 		INTCON2.TMR0IP = 1; // TMR0 interrupts are high priority
	BSF         INTCON2+0, 2 
;BMSToucan.c,336 :: 		INTCON3.INT2IE = 0; // disable INT2
	BCF         INTCON3+0, 4 
;BMSToucan.c,337 :: 		INTCON3.INT1IE = 1; // enable INT1
	BSF         INTCON3+0, 3 
;BMSToucan.c,338 :: 		INTCON.INT0IE = 1; // enable INT0
	BSF         INTCON+0, 4 
;BMSToucan.c,341 :: 		TRISC.B7 = 1; // set RX to input
	BSF         TRISC+0, 7 
;BMSToucan.c,342 :: 		TRISC.B6 = 0; // set TX to output
	BCF         TRISC+0, 6 
;BMSToucan.c,343 :: 		SPBRG = 64; // set the baud rate at 19.23Kbps @ 20MHz clock
	MOVLW       64
	MOVWF       SPBRG+0 
;BMSToucan.c,344 :: 		TXSTA.BRGH = 1; // high speed baud mode
	BSF         TXSTA+0, 2 
;BMSToucan.c,345 :: 		TXSTA.SYNC = 0; // asynchronous mode
	BCF         TXSTA+0, 4 
;BMSToucan.c,346 :: 		RCSTA.SPEN = 1; // enable the serial port
	BSF         RCSTA+0, 7 
;BMSToucan.c,347 :: 		TXSTA.TXEN = 1; // enable transmission
	BSF         TXSTA+0, 5 
;BMSToucan.c,348 :: 		RCSTA.CREN = 1; // enable receival
	BSF         RCSTA+0, 4 
;BMSToucan.c,349 :: 		TXSTA.TX9 = 0; // 8 bit transmission
	BCF         TXSTA+0, 6 
;BMSToucan.c,350 :: 		RCSTA.RX9 = 0; // 8 bit reception
	BCF         RCSTA+0, 6 
;BMSToucan.c,351 :: 		UART1_init(19200);
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;BMSToucan.c,354 :: 		TRISB.B3 = 1; // set CANRX for outputting transmission
	BSF         TRISB+0, 3 
;BMSToucan.c,355 :: 		TRISB.B2 = 0; // clear CANTX for inputting signal
	BCF         TRISB+0, 2 
;BMSToucan.c,358 :: 		T0CON.TMR0ON = 1; // turn on timer 0
	BSF         T0CON+0, 7 
;BMSToucan.c,359 :: 		T0CON.T08BIT = 1; // set up as an 8 bit timer
	BSF         T0CON+0, 6 
;BMSToucan.c,360 :: 		T0CON.T0CS = 0; // use the instruction clock as the timing signal
	BCF         T0CON+0, 5 
;BMSToucan.c,361 :: 		T0CON.PSA = 0; // use the prescaler
	BCF         T0CON+0, 3 
;BMSToucan.c,362 :: 		T0CON |= 0b00000111; // set a 1:256 prescaler on the T0
	MOVLW       7
	IORWF       T0CON+0, 1 
;BMSToucan.c,368 :: 		CANbus_setup();
	CALL        _CANbus_setup+0, 0
;BMSToucan.c,371 :: 		tx_counter = 0; // reset the transmit counter
	CLRF        _tx_counter+0 
	CLRF        _tx_counter+1 
;BMSToucan.c,372 :: 		flag_ovp = 0; // no ovp problem
	CLRF        _flag_ovp+0 
;BMSToucan.c,373 :: 		flag_lvp = 0; // no lvp problem
	CLRF        _flag_lvp+0 
;BMSToucan.c,374 :: 		flag_check_bms = 0; // don't check BMS
	CLRF        _flag_check_bms+0 
;BMSToucan.c,375 :: 		flag_send_can = 0; // no can messages to send yet
	CLRF        _flag_send_can+0 
;BMSToucan.c,376 :: 		current_cell = 0; // start by querying cell #1
	CLRF        _current_cell+0 
	CLRF        _current_cell+1 
;BMSToucan.c,377 :: 		}
L_end_setup:
	RETURN      0
; end of _setup
