Extension { #name : #ZnStatusLine }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine class >> gtExampleForbidden [
	<gtExample: 'Forbidden'>
	^ self forbidden
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine class >> gtExampleNotFound [
	<gtExample: 'Not Found'>
	^ self notFound
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine class >> gtExampleOk [
	<gtExample: 'Ok'>
	^ self ok
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStatusLine >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite rubricText
		title: 'HTTP';
		format: [ String streamContents: [ :out | self writeOn: out ] ]
]
