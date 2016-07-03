Class {
	#name : #GTExampleOLD,
	#superclass : #Object,
	#category : #'GT-Examples-DEPRECATED'
}

{ #category : #DEPRECATED }
GTExampleOLD >> afterFinish [
	^ afterFinish
]

{ #category : #DEPRECATED }
GTExampleOLD >> children [
	^ children
]

{ #category : #DEPRECATED }
GTExampleOLD >> childrenExamples [
	self deprecated: 'Please use #dependencies instead'.
	^ self dependencies
]

{ #category : #DEPRECATED }
GTExampleOLD >> dependenciesOrErrors [
	^ self arguments collect: [ :each | 
		[ each example ] 
			on: Error 
			do: [ :exception | exception ] ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> detachFromSystem [
	self detachResultFromSystem.
	(self traverser reversed
		action: [ :example | example detachResultFromSystem ];
		onRecursionError: [ :aProcessor :anExample | " ignore and continue " ];
		yourself) value.
	children do: [ :proxy | proxy detachFromSystem ].
	parents do: [ :proxy | proxy detachFromSystem ].
	children := OrderedCollection new.
	parents := Set new.
]

{ #category : #DEPRECATED }
GTExampleOLD >> detachResultFromSystem [
	result ifNil: [ ^ self ].
	result detachFromSystem.
	result := nil.
]

{ #category : #DEPRECATED }
GTExampleOLD >> extractionStrategy [
	self deprecated: 'Please define your examples using pragmas'.
	^ self shouldNotImplement
]

{ #category : #DEPRECATED }
GTExampleOLD >> extractionStrategy: anObject [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
]

{ #category : #DEPRECATED }
GTExampleOLD >> finder [ 
	^ finder
]

{ #category : #DEPRECATED }
GTExampleOLD >> gtDisplaySourceIn: composite [
	self deprecated: 'Please use #gtInspectorSourceIn: instead'.
	^ self gtInspectorSourceIn: composite
]

{ #category : #DEPRECATED }
GTExampleOLD >> gtExampleFrom: aSelector [
	self deprecated: 'Please define your example-dependencies using the pragma #depends: or #dependsClass:selector: or #dependsAll:'.
	self depends: aSelector
]

{ #category : #DEPRECATED }
GTExampleOLD >> hasDependent [
	^ self dependents notEmpty
]

{ #category : #DEPRECATED }
GTExampleOLD >> hasParentExample [
	self deprecated: 'Please use #hasDependent instead'.
	^ self hasDependent
]

{ #category : #DEPRECATED }
GTExampleOLD >> ignoreCache [
	^ self propertyAt: #noCache ifAbsent: [ false ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> ignoreNotification [
	^ self propertyAt: #noNotification ifAbsent: [ false ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> initializeFromFinder: aFinder withPragma: aPragma [
	finder := aFinder.
	pragma := aPragma.
	source := aFinder source.
	provider := aFinder provider.	
	subjects := aFinder subjects.
	exceptions := ExceptionSet new.
	children := OrderedCollection new.
	parents := Set new.
	properties := IdentityDictionary new.
	
	aPragma method pragmas do: [ :p |
		(self class canPerform: p keyword) 
			ifTrue: [ self perform: p keyword withArguments: p arguments ] ].
]

{ #category : #DEPRECATED }
GTExampleOLD >> initializeIconWith: aBlock [
	<todo: 'come up with something better than an empty & generic exception handler'>
	" We don't want to throw exceptions while examples are being created. We regard those as optional / nice-to-have. "
	[ aBlock value ]
		on: Error
		do: [ :exception | ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> methodForClass: aClassOrClassName selector: aSelector [
	^ aClassOrClassName isClass 
		ifTrue: [ self methodForProvider: aClassOrClassName gtExamplesProvider selector: aSelector ]
		ifFalse: [ self methodForClassNamed: aClassOrClassName selector: aSelector ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> methodForProvider: aProvider selector: aSelector [
	^ GTExampleProviderMethod new
		provider: aProvider;
		selector: aSelector asSymbol;
		yourself
]

{ #category : #DEPRECATED }
GTExampleOLD >> noCache [
	<gtExamplePragma>
	<description: 'Never cache the result/returnValue of this example'>
	
	self propertyAt: #noCache put: true
]

{ #category : #DEPRECATED }
GTExampleOLD >> noNotification [
	<gtExamplePragma>
	<description: 'Do not show any notification for this example'>
	
	self propertyAt: #noNotification put: true
]

{ #category : #DEPRECATED }
GTExampleOLD >> parentExample: anObject [
	self deprecated: 'Please use #dependencies or #children instead'.
	self shouldNotImplement
]

{ #category : #DEPRECATED }
GTExampleOLD >> parents [
	^ parents
]

{ #category : #DEPRECATED }
GTExampleOLD >> pragma [
	^ pragma
]

{ #category : #DEPRECATED }
GTExampleOLD >> providerClass [
	^ self provider class
]

{ #category : #DEPRECATED }
GTExampleOLD >> proxyForClass: aClass selector: aSelector [
	" we have to resolve the kind of example again - it could be implemented in #class or in the provider of #class ! "
	^ self proxyForProvider: aClass gtExamplesProvider selector: aSelector
]

{ #category : #DEPRECATED }
GTExampleOLD >> proxyForProvider: aProvider selector: aSelector [
	^ GTExampleProxy new
		owner: self;
		provider: aProvider;
		selector: aSelector asSymbol;
		yourself
]

{ #category : #DEPRECATED }
GTExampleOLD >> proxyForSelector: aSelector [
	^ self proxyForProvider: self provider selector: aSelector
]

{ #category : #DEPRECATED }
GTExampleOLD >> removeFromSystem [
	self finder remove: self ifPresent: [ self detachFromSystem ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> result [
	^ result ifNil: [ self run ]
]

{ #category : #DEPRECATED }
GTExampleOLD >> result: aResult [
	result := aResult
]

{ #category : #DEPRECATED }
GTExampleOLD >> resultCached [
	^ result
]

{ #category : #DEPRECATED }
GTExampleOLD >> resultCached: aResult [
	self ignoreCache ifFalse: [ result := aResult ].
	GTExampleNautilus methodUpdated: self method with: aResult.
	^ aResult
]

{ #category : #DEPRECATED }
GTExampleOLD >> source [
	^ source
]

{ #category : #DEPRECATED }
GTExampleOLD >> title [
	self deprecated: 'Please define your examples using pragmas'.
	^ self label
]

{ #category : #DEPRECATED }
GTExampleOLD >> title: aString [
	self deprecated: 'Please define your examples using pragmas'.
	self label: aString
]
