Class {
	#name : #GTDummyExamplesPragmas,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-1'
}

{ #category : #examples }
GTDummyExamplesPragmas class >> a [
	<gtExample>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> b [
	<gtExample>
	<label: 'Dummy #b with a label'>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> c [
	<gtExample>
	<description: 'Dummy #c without label but with a description'>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> d [
	<gtExample>
	<label: 'Dummy #d'>
	<description: 'Dummy #d with label and description'>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> e [
	<gtExample>
	<label: 'Dummy #e'>
	<description: 'Dummy #e with an icon (default behaviour)'>
	<icon: #pageIcon>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> f [
	<gtExample>
	<label: 'Dummy #f'>
	<description: 'Dummy #f with an icon provided by the current theme'>
	<iconThemeSelector: #refreshIcon>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> g [
	<gtExample>
	<label: 'Dummy #g'>
	<description: 'Dummy #g with an icon provided by the current provider'>
	<iconSelector: #iconForG>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> h [
	<gtExample>
	<label: 'Dummy #h'>
	<description: 'Dummy #h with an icon based on the given base64 string'>
	<iconBase64: 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAADrSURBVDjLY/z//z8DJYCJgUIw
yAwoPZHJBsS7STGABY1/9e+fvzKkGMAIiwWgzRfF2ST0/vz5w/Dw/UOGXz9/M/z6AcK/GH4C
MZj+jmCD5C70X2VkgWo+KcYqrqfArcTw598fBhluOTD9++9fIP7N8PsfEP/9AxUD0b8ZVq9c
i/AC0Nm//zD+Yfj19xdY0R+got9gxb8RNNQAkNyf/0CxX39QvZC5M+68MJuIAQczJ8PDlw8Z
Xr9/g9XZIK+BNP/5/Yfh/sJHjIzIKTF2VchNoEI5oAbHDWk7TpAcjUDNukDNB4nVjOKFEZwX
AOOhu7x6WtPJAAAAAElFTkSuQmCC'>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> i [
	<gtExample>
	<label: 'Dummy #i'>
	<description: 'Dummy #i with an icon based on the given bytes'>
	<iconBytes: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 0 0 0 0 0 0 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 4278190080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> iconForG [
	^ Smalltalk ui icons bookIcon
]

{ #category : #examples }
GTDummyExamplesPragmas class >> iconForJ [
	^ Smalltalk ui icons bookIcon 
]

{ #category : #examples }
GTDummyExamplesPragmas class >> j [
	<gtExample>
	<label: 'Dummy #i'>
	<description: 'Dummy #i with an icon based on the given bytes'>
	<iconClass: #GTDummyExamplesPragmas selector: #iconForJ>

]

{ #category : #examples }
GTDummyExamplesPragmas class >> k [
	<gtExample>
	<label: 'Dummy #k'>
	<description: 'Dummy #k, with subject Boolean (returns true)'>
	<subject: #Boolean>
	
	^ true & ( false == false ) | true | ( false ~= true )
]

{ #category : #examples }
GTDummyExamplesPragmas class >> l [
	<gtExample>
	<label: 'Dummy #l'>
	<description: 'Dummy #l, with subjects Boolean and Number (returns true)'>
	<subject: #Boolean>
	<subject: #Number>
	
	^ true & ( 1 == 1 ) & (1 + 1 = 2)
]

{ #category : #examples }
GTDummyExamplesPragmas class >> m [
	<gtExample>
	<label: 'Dummy #m'>
	<description: 'Dummy #m, with subjects Boolean and Number (returns true)'>
	<subjectsAll: 'Boolean Number, Date . Duration ; Float'>
	
	^ true & ( 1 == 1 ) & ( Date today = Date today ) & ( Duration seconds: 0 ) isZero & Float pi isFloat
]
