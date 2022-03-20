"
I implement the backend for the serial port implementation.
I am responsible of looking up the correct port and using the correct implementation.
I guarantee that a single port is only open once and shared if it is required by many SerialPort instances.
"
Class {
	#name : #SerialPortBackend,
	#superclass : #Object,
	#instVars : [
		'ports'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #SerialPort
}

{ #category : #accessing }
SerialPortBackend class >> uniqueInstance [
	
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #operations }
SerialPortBackend >> closePort: aString [ 
	
	(self lookupPort: aString) close
]

{ #category : #initialization }
SerialPortBackend >> initialize [

	super initialize.
	ports := Dictionary new
]

{ #category : #private }
SerialPortBackend >> lookupPort: anIntegerOrString [

	| portName |
	portName := anIntegerOrString isInteger
		            ifTrue: [ self translatePortByNumber: anIntegerOrString ]
		            ifFalse: [ anIntegerOrString ].
		
	^ ports at: portName ifAbsentPut: [ 
		OSPlatform current newSerialPortImplementation
			portName: portName;
			yourself ]
]

{ #category : #operations }
SerialPortBackend >> openPort: aPortId baudRate: baudRate stopBitsType: stopBitsType parityType: parityType dataBits: dataBits inFlowControlType: inFlowControlType outFlowControlType: outFlowControlType xOnByte: xOnByte xOffByte: xOffByte [

	| port |
	port := self lookupPort: aPortId.

	port
		openPortWithBaudRate: baudRate
		stopBitsType: stopBitsType
		parityType: parityType
		dataBits: dataBits
		inFlowControlType: inFlowControlType
		outFlowControlType: outFlowControlType
		xOnByte: xOnByte
		xOffByte: xOffByte.

	^ port portId
]

{ #category : #operations }
SerialPortBackend >> readPort: aPortName into: aByteArray startingAt: start count: count [

	^ (self lookupPort: aPortName)
		readInto: aByteArray
		startingAt: start
		count: count
]

{ #category : #operations }
SerialPortBackend >> writePort: aPortId from: aByteArray startingAt: starting count: count [ 
	
	^ (self lookupPort: aPortId)
			writeFrom: aByteArray startingAt: starting count: count
]
