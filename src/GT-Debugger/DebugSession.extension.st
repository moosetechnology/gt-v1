Extension { #name : #DebugSession }

{ #category : #'*gt-debugger' }
DebugSession >> createPredicateForBlock: aBlock [ 

	^ BlockContextPredicate for: aBlock
]

{ #category : #'*gt-debugger' }
DebugSession >> createStepPredicateForBlock: aBlock [ 

	^ self createStepPredicatForPredicate: (self createPredicatForBlock: aBlock)
			
]

{ #category : #'*gt-debugger' }
DebugSession >> createStepPredicateForPredicate: aPredicate [
	" Subclasses should specialize this method if needed. "
	^ aPredicate
]

{ #category : #'*gt-debugger' }
DebugSession >> createStepPredicateForPredicate: aPredicate fromContext: targetContext [

	^ (self createPredicateForBlock: [ :currentContext |
		(self isActive: targetContext) not or: [ currentContext isHaltContext ] ]) 
			or: aPredicate
	
]

{ #category : #'*gt-debugger' }
DebugSession >> isActive: aContext [

	^ true
]

{ #category : #'*gt-debugger' }
DebugSession >> stepUntil: aPredicate from: aContext [ 
	| ctxt |
	
	ctxt := self process stepUntil: (self createStepPredicateForPredicate: aPredicate) from: aContext.
	self  
		updateWithContext: ctxt 
		fromProcess: self process.
]
