Extension { #name : #ZnStringEntity }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity class >> gtExampleEmptyHtml [
	<gtExample>
	<label: 'Empty HTML'>
	
	^ self html: ''
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity class >> gtExampleEmptyText [
	<gtExample>
	<label: 'Empty text'>
	
	^ self text: ''
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity class >> gtExampleEmptyXml [
	<gtExample>
	<label: 'Empty XML'>
	
	^ self xml: ''
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity class >> gtExampleHtml [
	<gtExample>
	<label: 'HTML'>
	
	^ self html: '<p><b>Hello</b> <i>World<i></p>'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity class >> gtExampleText [
	<gtExample>
	<label: 'Text'>
	
	^ self text: 'Hello World'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity class >> gtExampleXml [
	<gtExample>
	<label: 'XML'>
	
	^ self xml: '<message>Hello World</message>'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnStringEntity >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite rubricText
		title: 'Contents';
		format: self string
]
