Extension { #name : #GTExample }

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> childrenExamples [
	self deprecated: 'Please use #dependencies instead'.
	^ self dependencies
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy [
	self deprecated: 'Please define your examples using pragmas'.
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy: anObject [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtDisplaySourceIn: composite [
	<todo: 'deprecated: #gtDisplaySourceIn:'>
	^ self gtInspectorSourceIn: composite
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExample: anObject [
	self deprecated: 'Please define your example-label (or description) using the pragma #label: or #description:'.
	self label: anObject.
	self gtExample
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExampleFrom: aSelector [
	self deprecated: 'Please define your example-dependencies using the pragma #depends: or #dependsClass:selector: or #dependsAll:'.
	self depends: aSelector
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> hasParentExample [
	self deprecated: 'Please use #hasDependent instead'.
	^ self hasDependent
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> methodReference [
	self deprecated: 'The selector #methodReference is obsolete'.
	^ self method asRingDefinition
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> parentExample: anObject [
	self deprecated: 'Please use #dependencies or #children instead'.
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> provider: aClassOrInstance [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector [
	self deprecated: 'Please define your examples using pragmas'.
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector: aSelector [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title [
	self deprecated: 'Please define your examples using pragmas'.
	^ self label
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title: aString [
	self deprecated: 'Please define your examples using pragmas'.
	self label: aString
]
