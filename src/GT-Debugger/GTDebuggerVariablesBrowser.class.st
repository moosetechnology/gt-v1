"
I am a special browser that is used in the first pane of the inspector that is embedded in the debugger. Its main intention is to provide a unified list of variables that come from:
- the instance variables of the receiver
- the local variables from the context
"
Class {
	#name : #GTDebuggerVariablesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Debugger-UI'
}

{ #category : #'as yet unclassified' }
GTDebuggerVariablesBrowser >> compareVariableTypeOf: x withVariable: y in: aContext [

	^ (self variableTypeOf: x in: aContext) < (self variableTypeOf: y in: aContext)
]

{ #category : #building }
GTDebuggerVariablesBrowser >> compose [  
	"self title: [:each | GTInspector new printObjectAsAnItem: each receiver ]."
	"self morphicAct: [:anotherComposite | anotherComposite entity receiver browse]
				icon: GLMUIThemeExtraIcons glamorousBrowse 
				entitled: 'Browse'."
	self tabulator with: [:browser | 
		browser row: #variables.
		browser transmit to: #variables; andShow: [:a | 
			self variablesIn: a ].
		browser transmit from: #variables; toOutsidePort: #selection ]
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> tagsForVariable: aString from: aContext [
	^ (aContext reservedNames includes: aString) 
		ifTrue: [ #() ]
		ifFalse: [ self variableTypeOf: aString in: aContext ]
			
	
]

{ #category : #'as yet unclassified' }
GTDebuggerVariablesBrowser >> variableTypeOf: aString in: aContext [
	^ (aContext receiver class classThatDefinesInstanceVariable: aString) notNil
			ifTrue: [ 'attribute' ]
			ifFalse: [ (aContext method argumentNames includes: aString)
				ifTrue: [ 'parameter' ]
				ifFalse: [ 'temp' ] ]
			
	
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> variablesFromContext: aContext [ 

	^ aContext gtDebuggerRetrieveVariableValuePairs
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> variablesIn: composite [
	^ composite table
		showOnly: 50;
		shouldValidate: false;
		allowsRecursiveSearch: false;
		display: [ :context | self variablesFromContext: context ];
		column: 'Type'
			evaluated: [ '' ]
			width: 75
			tags: [ :assoc :context |
				self tagsForVariable: assoc key from: context ]
			sortedBy: [ :x :y | 
				self 
					compareVariableTypeOf: x key
					withVariable: y key
					in: ((self presentations first paneNamed: #variables) port: #entity) value];
		column: 'Variable' 
			evaluated: [:assoc | 
			[ Text fromString: assoc key asString ]
					on: Error
					do: [ Text string: 'error printing' attribute: TextColor red ] ]
			width: 175;
		column: 'Value' evaluated: [:assoc | 
			[ Text fromString: (assoc value printString contractTo: 50) ]
					on: Error
					do: [ Text string: 'error printing' attribute: TextColor red ] ];
		send: #value;
		morphicSelectionAct: [:list | list selection value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse';
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect'
]
