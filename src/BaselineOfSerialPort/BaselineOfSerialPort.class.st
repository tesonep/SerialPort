Class {
	#name : #BaselineOfSerialPort,
	#superclass : #BaselineOf,
	#category : #BaselineOfSerialPort
}

{ #category : #baselines }
BaselineOfSerialPort >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			package: 'SerialPort'.
			
		spec 
			group: 'default' with: #('SerialPort') ]
]
