Extension { #name : #AbstractNautilusUI }

{ #category : #'*GT-Chatter' }
AbstractNautilusUI >> chatAboutSelection: aSelection [ 
	| aMethod aRing aMessage |
	aMethod := self selectedMethod.  
	aRing := aMethod asFullRingDefinition.
	aMessage := GTCSelectionInMethodMessage new.
	aMessage 
		ring: aRing;
		selection: aSelection.
	GTChatter me send: aMessage.
]
