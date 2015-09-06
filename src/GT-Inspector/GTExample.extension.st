Extension { #name : #GTExample }

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> childrenExamples [
	<todo: 'deprecated: #childrenExamples'>
	^ self dependencies
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy [
	<todo: 'deprecated: #extractionStrategy'>
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy: anObject [
	<todo: 'deprecated: #extractionStrategy:'>
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtDisplaySourceIn: composite [
	<todo: 'deprecated: #gtDisplaySourceIn:'>
	^ self gtInspectorSourceIn: composite
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExample: anObject [
	<todo: 'deprecated: #gtExample:'>
	self label: anObject.
	^ self gtExample
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExampleFrom: aSelector [
	<todo: 'deprecated: #gtExampleFrom:'>
	^ self depends: aSelector
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> hasParentExample [
	<todo: 'deprecated: #hasParentExample'>
	^ self dependents notEmpty
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> methodReference [
	<todo: 'deprecated: #methodReference'>
	^ self method asRingDefinition
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> parentExample: anObject [
	<todo: 'deprecated: #parentExample:'>
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector [
	<todo: 'deprecated: #selector'>
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector: aSelector [
	<todo: 'deprecated: #selector:'>
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title [
	<todo: 'deprecated: #title'>
	^ self gtDisplayString
	"
	^ title 
		ifNil: [ self result ]
		ifNotNil: [ title ]
	"
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title: aString [
	<todo: 'deprecated: #title:'>
	self label: aString
	"
	title: aString
		title := aString
	"
]
