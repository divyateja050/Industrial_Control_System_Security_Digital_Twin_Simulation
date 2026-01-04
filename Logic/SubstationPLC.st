PROGRAM SubstationPLC
  VAR
    Isolator_Status AT %QX0.0 : BOOL;
    Remote_Start AT %QX0.1 : BOOL;
    Manual_Stop AT %QX0.2 : BOOL;
    Breaker_Coil AT %QX0.3 : BOOL;
  END_VAR

  Breaker_Coil := NOT(Manual_Stop) AND (Breaker_Coil OR Remote_Start) AND Isolator_Status;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : SubstationPLC;
    PROGRAM instance1 WITH task0 : SubstationPLC;
  END_RESOURCE
END_CONFIGURATION
