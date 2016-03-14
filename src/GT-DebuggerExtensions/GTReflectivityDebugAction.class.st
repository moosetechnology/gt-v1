Class {
	#name : #GTReflectivityDebugAction,
	#superclass : #DebugAction,
	#instVars : [
		'breakpoints',
		'debuggerData'
	],
	#category : #'GT-DebuggerExtensions'
}

{ #category : #adding }
GTReflectivityDebugAction >> addBreakpoint: aBreakpoint [

	aBreakpoint targetAction: self.
	self breakpoints add: aBreakpoint
]

{ #category : #callbacks }
GTReflectivityDebugAction >> breakpointReachedFrom: aBreakpoint [

	breakpoints do: #uninstall.

	UIManager default 
		debugProcess: Processor activeProcess 
		context: (aBreakpoint instrumentationContextFrom: thisContext)
		label: (self debuggerData at: #title)
		fullView: true 
		notification: nil 
		usingDebugger: GTPPDebugger
		initializedWith: [ :aDebugger | 
			"aBreakpoint updateDebuggingSession: aDebugger session."
			aDebugger window 
				position: (self debuggerData at: #position);
				extent: (self debuggerData at: #extent) ]
]

{ #category : #accessing }
GTReflectivityDebugAction >> breakpoints [

	^ breakpoints ifNil: [ breakpoints := OrderedCollection new ]
]

{ #category : #accessing }
GTReflectivityDebugAction >> debuggerData [

	^ debuggerData ifNil: [ debuggerData := Dictionary new ]
]

{ #category : #actions }
GTReflectivityDebugAction >> executeAction [

	self attachBreakpoints.
	self installBreakpoints.
	self resumeDebugger.
]

{ #category : #initialization }
GTReflectivityDebugAction >> initialize [
	super initialize.
	self needsUpdate: false
]

{ #category : #actions }
GTReflectivityDebugAction >> installBreakpoints [

	breakpoints do: #install.
]

{ #category : #actions }
GTReflectivityDebugAction >> resumeDebugger [

	self saveDebuggerData.
	self session 
		resume;
		clear.
	self debugger close. 
]

{ #category : #actions }
GTReflectivityDebugAction >> saveDebuggerData [

	self debuggerData at: #title put: self debugger title.
	self debuggerData at: #position put: self debugger window position.
	self debuggerData at: #extent put: self debugger window extent.
]
