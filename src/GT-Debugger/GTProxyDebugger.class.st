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

{ #category : #initialize }
GTProxyDebugger >> preDebugButtonQuads [
	| buttons |
	self isPostMortem 
		ifTrue: [ ^ self postMortemPreDebugButtonQuads ].
	^ {
		{'Proceed' translated.	#proceed. 	#blue. 	'Continue execution' translated}.
		{'Abandon' translated.	#abandon. 	#black.	'Abandon this execution by closing this window' translated}.
		{'Debug'    		translated.		#debug.		#red. 	'Bring up a debugger' translated}.
		{'New Debugger' translated. #spanNewDebugger. #red. 'Bring up the new debugger' translated}
	}
]

{ #category : #'notifier menu' }
GTProxyDebugger >> spanNewDebugger [
	"Open a full DebuggerView."
	| topView |
	topView := self topView.
	topView model: nil.
	"so close won't release me."
	self breakDependents.
	topView delete.
	
	GTDebugger debugContext: self interruptedContext fromProcess: self interruptedProcess
]
