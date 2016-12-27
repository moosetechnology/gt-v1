Extension { #name : #GlamourPresentationModel }

{ #category : #'*GT-Inspector' }
GlamourPresentationModel class >> exampleInspectorOn42 [
	<gtExample>
	"open an inspector on 42"
	|ui|
	ui := GlamourPresentationModel new.
	ui presentationClass: GTInspector startOn: 42.
	^ ui openWithSpec
]

{ #category : #'*GT-Inspector' }
GlamourPresentationModel class >> exampleSimpleMethodsBrowser [
	<gtExample>
	"open a Methods Browser on Object"
	|ui|
	ui := GlamourPresentationModel new.
	ui presentationClass: GTSimpleMethodsBrowser startOn: Object.
	^ ui openWithSpec
]
