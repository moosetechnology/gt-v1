Class {
	#name : #GTCChatAboutStackDebugAction,
	#superclass : #FuelOutStackDebugAction,
	#category : #'GT-Chatter-Integration'
}

{ #category : #registration }
GTCChatAboutStackDebugAction class >> actionType [
	<contextMenuDebuggingAction>
]

{ #category : #registration }
GTCChatAboutStackDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			order: 30
]

{ #category : #serialization }
GTCChatAboutStackDebugAction class >> newConfiguredSerializer [
	| serializer |	
	serializer := FLSerializer newDefault.
	self encodeDebugInformationOn: serializer. 
	serializer addPostMaterializationAction: [ :materialization | 
		Smalltalk tools debugger
			openOn: Processor activeProcess 
			context: materialization root 
			label: 'External stack' 
			contents: nil 
			fullView: false ].
	^ serializer
]

{ #category : #serialization }
GTCChatAboutStackDebugAction class >> serializeTestFailureContext: aContext on: aStream [
	| serializer |
	
	serializer := self newConfiguredSerializer.		
	serializer
		" use the sender context, generally the current context is not interesting"
		serialize: aContext
		on: aStream
]

{ #category : #accessing }
GTCChatAboutStackDebugAction >> defaultLabel [

	^ 'Chat About This Stack'
]

{ #category : #accessing }
GTCChatAboutStackDebugAction >> defaultOrder [

	^ 124
]

{ #category : #accessing }
GTCChatAboutStackDebugAction >> id [

	^ #chatAboutStack
]

{ #category : #instructions }
GTCChatAboutStackDebugAction >> send: aByteArray [
	| aMessage aReceiver |
	aMessage := GTCStackTraceMessage new.
	aMessage stack: aByteArray.
	aReceiver := GTChatter me selectRecipient.
	aMessage to: aReceiver.
	aReceiver ifNotNil: [ 
		[ GTChatter me send: aMessage ] forkAt: Processor userBackgroundPriority ].
]

{ #category : #actions }
GTCChatAboutStackDebugAction >> serializeStack [
	| aByteArray |
	'Serializing stack...' displayProgressFrom: 0 to: 1 during: [ :mainBar |	
		[ aByteArray := ByteArray streamContents: [ :aStream |
				self class
					serializeTestFailureContext: self interruptedContext copyStack		
					on: aStream ] ] 
		on: Error 
		do: [:err| self inform: 'Stack fuelling failed ', String cr, err printString "and simply continue..." ].
		mainBar current: 1. 
	].
	self send: aByteArray. 
]
