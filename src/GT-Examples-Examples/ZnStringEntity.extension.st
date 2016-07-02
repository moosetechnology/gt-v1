Extension { #name : #ZnStringEntity }

{ #category : #'*GT-Examples-Examples' }
ZnStringEntity class >> gtExampleEmptyHtml [
	<gtExample>
	<label: 'Empty HTML'>
	
	^ self html: ''
]

{ #category : #'*GT-Examples-Examples' }
ZnStringEntity class >> gtExampleEmptyText [
	<gtExample>
	<label: 'Empty text'>
	
	^ self text: ''
]

{ #category : #'*GT-Examples-Examples' }
ZnStringEntity class >> gtExampleEmptyXml [
	<gtExample>
	<label: 'Empty XML'>
	
	^ self xml: ''
]

{ #category : #'*GT-Examples-Examples' }
ZnStringEntity class >> gtExampleHtml [
	<gtExample>
	<label: 'HTML'>
	
	^ self html: '<p><b>Hello</b> <i>World<i></p>'
]

{ #category : #'*GT-Examples-Examples' }
ZnStringEntity class >> gtExampleText [
	<gtExample>
	<label: 'Text'>
	
	^ self text: 'Hello World'
]

{ #category : #'*GT-Examples-Examples' }
ZnStringEntity class >> gtExampleXml [
	<gtExample>
	<label: 'XML'>
	
	^ self xml: '<message>Hello World</message>'
]
