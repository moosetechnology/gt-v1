Extension { #name : #GlamourPresentationModel }

{ #category : #'*GT-Playground' }
GlamourPresentationModel class >> examplePlaygroundAndInspectorOn42 [
	<gtExample>
	|ui lay|	
	ui := DynamicComposableModel new.
	ui title: 'Too Much Glamour!' translated.
	ui instantiateModels: #(
		play GlamourPresentationModel
		insp GlamourPresentationModel).
	
	ui play presentationClass: GTPlayground startOn: (GTPlayPage new saveContent: '42').
	ui insp presentationClass: GTInspector startOn: 42.
	
	lay := SpecLayout composed
		newColumn: [ :c |
			c newRow: [ :r | r add: #play];
			newRow: [ :r | r add: #insp ]];
		yourself.
		
	ui openWithSpecLayout: lay.
]

{ #category : #'*GT-Playground' }
GlamourPresentationModel class >> examplePlaygroundOn42 [
	<gtExample>
	"open a playground on 42"
	|ui|
	ui := GlamourPresentationModel new.
	ui presentationClass: GTPlayground startOn: (GTPlayPage new saveContent: '42').
	^ ui openWithSpec
]
