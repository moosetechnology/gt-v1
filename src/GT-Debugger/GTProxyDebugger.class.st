"
GTProxyDebugger is a simple extension of the existing debugger that adds a button for ""debug glamorously"" using the GTDebugger in the regular debugger.

The goal is to provide the possibility of having the GTDebugger next to the classic debugger until the inevitable errors are ironed out.
"
Class {
	#name : #GTProxyDebugger,
	#superclass : #Debugger,
	#category : #'GT-Debugger'
}

{ #category : #'class initialization' }
GTProxyDebugger class >> initialize [
	super initialize.

	"Add ourselves to registry. See [Smalltalk tools]" 
	Smalltalk tools register: self as: #debugger
]

{ #category : #accessing }
GTProxyDebugger >> debuggerClass [
	^ GTDebugger 
]

{ #category : #initialize }
GTProxyDebugger >> preDebugButtonQuads [
	| buttons |
	self isPostMortem 
		ifTrue: [ ^ self postMortemPreDebugButtonQuads ].
	^ {
		{'Proceed' translated.	#proceed. 	#blue. 	'Continue execution' translated}.
		{'Abandon' translated.	#abandon. 	#black.	'Abandon this execution by closing this window' translated}.
		{'Debug'    		translated.		#debug.		#red. 	'Bring up a debugger' translated}.
		{'Debug glamorously' translated. #spawnGTDebugger. #red. 'Bring up the Glamorous Debugger' translated}
	}
]

{ #category : #'notifier menu' }
GTProxyDebugger >> spawnGTDebugger [
	| topView |
	topView := self topView.
	topView model: nil.
	"so close won't release me."
	self breakDependents.
	topView delete.
	
	self debuggerClass debugContext: self interruptedContext fromProcess: self interruptedProcess
]
