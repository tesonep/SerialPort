Class {
	#name : #SerialPortTest,
	#superclass : #TestCase,
	#instVars : [
		'sp'
	],
	#category : #SerialPort
}

{ #category : #tests }
SerialPortTest >> defaultTimeLimit [

	^ 1 minute
]

{ #category : #tests }
SerialPortTest >> portName [

	OSPlatform current isMacOSX ifTrue: [ ^ '/dev/cu.wchusbserial141330' ].
	OSPlatform current isUnix ifTrue: [ ^ '/dev/ttyUSB0' ].
	OSPlatform current isWindows ifTrue: [ ^ 'COM4' ].
	
	1halt

]

{ #category : #tests }
SerialPortTest >> tearDown [ 

	sp close
]

{ #category : #tests }
SerialPortTest >> testOpenArduino [

	"Testing a simple echo Arduino program: 
	
	String incoming;    // for incoming serial data

	void setup() {
	    Serial.begin(38400);    // opens serial port, sets data rate to 9600 bps
	}

	void loop() {
	  // send data only when you receive data:
	  if (Serial.available() > 0) {
	    // read the incoming byte:
	    incoming = Serial.readString();
	  
	    // say what you got:
	    Serial.print(incoming.length());
	  }
	  
	}
	"

	| stringToSend receivedString |
	sp := SerialPort new.
	sp baudRate: 38400.
	sp openPort: self portName.

	1 to: 10 do: [ :i | 
		stringToSend := DateAndTime now printString.
		sp writeByteArray: stringToSend utf8Encoded.
		receivedString := (sp readByteArray: 10000) utf8Decoded.
		self assert: receivedString equals: stringToSend size printString ]
]
