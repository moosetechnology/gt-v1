Extension { #name : #ZnStatusLine }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine class >> gtExampleForbidden [
	<gtExample>
	<label: 'Forbidden'>
	
	^ self forbidden
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine class >> gtExampleNotFound [
	<gtExample>
	<label: 'Not Found'>
	
	^ self notFound
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine class >> gtExampleOk [
	<gtExample>
	<label: 'Ok'>
	
	^ self ok
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite text
		title: 'HTTP';
		format: [ String streamContents: [ :out | self writeOn: out ] ]
]
