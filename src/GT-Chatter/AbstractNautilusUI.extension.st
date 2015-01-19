Extension { #name : #AbstractNautilusUI }

{ #category : #'*GT-Chatter' }
AbstractNautilusUI >> chatAboutSelection: aSelection [ 
	| aMethod aRing aMessage aReceiver |
	aMethod := self selectedMethod.  
	aRing := aMethod asFullRingDefinition.
	aRing 
		sourceCode: aMethod sourceCode;
		protocol: aMethod protocol;
		stamp: aMethod stamp.
	aMessage := GTCSelectionInMethodMessage new.
	aMessage 
		ring: aRing;
		selection: aSelection.
	aReceiver := GTChatter me selectRecipient.
	aMessage to: aReceiver.
	aReceiver ifNotNil: [ GTChatter me send: aMessage ].
]
