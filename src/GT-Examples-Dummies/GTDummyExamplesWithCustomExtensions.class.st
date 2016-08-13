Class {
	#name : #GTDummyExamplesWithCustomExtensions,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtInspectorActionFor2: aGTExample [
	^ GLMGenericAction new
		action: [ aGTExample inspect ];
		icon: GLMUIThemeExtraIcons glamorousInspect;
		title: 'Custom Inspect 2'
]

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtInspectorActionFor: anExample [
	^ GLMGenericAction new
		action: [ anExample inspect ];
		icon: GLMUIThemeExtraIcons glamorousInspect;
		title: 'Custom Inspect'
]

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtInspectorFor: aComposite example1: aGTExample [
	(aGTExample gtInspectorMethodIn: aComposite)
		title: 'Custom Extension 2'
]

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtInspectorFor: aComposite example2: aGTExample [
	(aGTExample gtInspectorMethodIn: aComposite)
		title: 'Custom Extension 2'
]

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtSpotterStep: aStep example2: aGTExample [
	aStep listProcessor
		title: 'Custom Extension 2 -- ' , aGTExample gtDisplayString;
		items: [ Array with: aGTExample ];
		itemName: [ :aSource | aSource gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtSpotterStep: aStep example3: aGTExample [
	aStep listProcessor
		title: 'Custom Extension 3 -- ' , aGTExample gtDisplayString;
		items: [ Array with: aGTExample ];
		itemName: [ :aSource | aSource gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #extensions }
GTDummyExamplesWithCustomExtensions >> gtSpotterStep: aStep example: aGTExample [
	aStep listProcessor
		title: 'Custom Extension 1 -- ' , aGTExample gtDisplayString;
		items: [ Array with: aGTExample ];
		itemName: [ :aSource | aSource gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #examples }
GTDummyExamplesWithCustomExtensions >> inspectorExtension1 [
	<gtExample>
	<inspector: #gtInspectorFor:example1:>
]

{ #category : #examples }
GTDummyExamplesWithCustomExtensions >> inspectorExtension2 [
	<gtExample>
	<inspectorClass: 'GTDummyExamplesWithCustomExtensions' selector: #gtInspectorFor:example1:>
	<inspector: #gtInspectorFor:example2:>
]

{ #category : #examples }
GTDummyExamplesWithCustomExtensions >> inspectorExtension3 [
	<gtExample>
	<inspectorActionClass: 'GTDummyExamplesWithCustomExtensions' selector: #gtInspectorActionFor:>
	<inspectorAction: #gtInspectorActionFor2:>
]

{ #category : #examples }
GTDummyExamplesWithCustomExtensions >> spotterExtension [
	<gtExample>
	<spotterClass: 'GTDummyExamplesWithCustomExtensions' selector: #gtSpotterStep:example:>
]

{ #category : #examples }
GTDummyExamplesWithCustomExtensions >> spotterExtension2 [
	<gtExample>
	<spotterClass: 'GTDummyExamplesWithCustomExtensions' selector: #gtSpotterStep:example:>
	<spotter: #gtSpotterStep:example2:>
]

{ #category : #examples }
GTDummyExamplesWithCustomExtensions >> spotterExtension3 [
	<gtExample>
	<spotter: #gtSpotterStep:example3:>
]
