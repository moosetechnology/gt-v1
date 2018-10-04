Class {
	#name : #BaselineOfGTDebugger,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTDebugger
}

{ #category : #baselines }
BaselineOfGTDebugger >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GTInspectorCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ].
		spec 
			package: 'GT-Debugger' with: [ 
				spec requires: #( 'GTInspectorCore' )];
			package: 'GT-BytecodeDebugger' with: [ 
				spec	requires: #( 'GT-Debugger') ];
			package: 'GT-SUnitDebugger' with: [ 
				spec requires: #( 'GT-Debugger') ];
		 	package: 'GT-Tests-Debugger' with: [ 
				spec requires: #( 'GT-Debugger' 'GT-BytecodeDebugger' 'GT-SUnitDebugger' )] ].

]
