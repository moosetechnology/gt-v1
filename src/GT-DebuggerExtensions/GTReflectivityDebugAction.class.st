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
GTReflectivityDebugAction >> attachBreakpoints [
	self subclassResponsibility
]

{ #category : #callbacks }
GTReflectivityDebugAction >> breakpointReachedFrom: aBreakpoint [
	"Callback method called when any one of the breakpoints installed 
	by this action is reached."

	self uninstallBreakpoints.
	self openDebuggerForBreakpoint: aBreakpoint
]

{ #category : #accessing }
GTReflectivityDebugAction >> breakpoints [

	^ breakpoints ifNil: [ breakpoints := OrderedCollection new ]
]

{ #category : #accessing }
GTReflectivityDebugAction >> debuggerClass [
	self subclassResponsibility
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
	self breakpoints do: #install.
]

{ #category : #opening }
GTReflectivityDebugAction >> openDebuggerForBreakpoint: aBreakpoint [
	|ctxt|
	ctxt := thisContext.
	
	UIManager default 
		debugProcess: Processor activeProcess 
		context: (aBreakpoint instrumentationContextFrom: ctxt)
		label: (self debuggerData at: #title)
		fullView: true 
		notification: nil 
		usingDebugger: self debuggerClass
		initializedWith: [ :aDebugger | 
			"FIX ME: do not update the entire debugger. Instead have a hook for updating the 
			session before opening the debugger and one after to update the actual debugger."
			aBreakpoint updateDebuggingSession: aDebugger session.
			aDebugger updateBrowser. 
			aDebugger window 
				position: (self debuggerData at: #position);
				extent: (self debuggerData at: #extent) ]
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

{ #category : #actions }
GTReflectivityDebugAction >> uninstallBreakpoints [
	self breakpoints do: #uninstall.
]
