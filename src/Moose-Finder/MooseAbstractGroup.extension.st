Extension { #name : #MooseAbstractGroup }

{ #category : #'*moose-finder' }
MooseAbstractGroup >> asMooseFinderItemNamed: aString in: aMooseEntity [

	^ self
]

{ #category : #'*moose-finder' }
MooseAbstractGroup >> mooseFinderListIn: composite [
	<moosePresentationOrder: 1>
	composite list
		beMultiple;
		showOnly: 50;
		searchOn: [ :text :each | Smalltalk compiler evaluate: ' | entity each | each := self. entity := each.' , text for: each logged: false ];
		display: #mooseInterestingEntity;
		sortBlock: [ :a :b | a mooseDisplayString < b mooseDisplayString ];
		send: [ :each | 
					each isNil
						ifTrue: [ nil ]
						ifFalse: [ each asMooseGroup ] ];
		format: #mooseDisplayString;
		icon: #mooseIcon;
		title: [ :each | each mooseInterestingEntity size asString , ' items' ];
		titleIcon: MooseIcons mooseList;
		when: [ :input | (input mooseInterestingEntity isKindOf: MooseGroup) or: [ input mooseInterestingEntity isKindOf: Collection ] ];
		dynamicActionsOnSelection: [ :list | list selection mooseInterestingEntity mooseFinderActions ];
		updateOn: MooseEntityAdded from: [ :anObject | MooseFinder announcerFor: anObject ];
		updateOn: MooseEntityRemoved from: [ :anObject | MooseFinder announcerFor: anObject ];
		helpMessage:
				'A selection boolean statement using ''each'' to refer to each element' , String cr , 'For example: ' , String cr
						, 'each beginsWith:''C'''
]

{ #category : #'*moose-finder' }
MooseAbstractGroup >> mooseFinderMetanoolIn: composite [
	composite magritte
		title: 'Meta editor';
		titleIcon: MooseIcons mooseEditor;
		display: [ :group | MTLGroup new group: group mooseInterestingEntity ];
		when: [ self notEmpty ];
		act: [:magritte |
			| result annotationDescription | 
			annotationDescription := MTLAnnotationDescription new.
			result := annotationDescription asMagritteMorph addButtons addWindow callInWorld.
			(result notNil) ifTrue: [ 
				magritte entity first mooseDescription attributes add: annotationDescription.
				magritte update ] ] 
			icon: GLMUIThemeExtraIcons glamorousAdd entitled: 'Add annotation';
		description: [ :group | group group first mooseDescription asMagritteDescriptionWithAnnotations ]
]

{ #category : #'*moose-finder' }
MooseAbstractGroup >> mooseSpecificSpotterProcessorsFor: aSpotterStep [
	"nothing because for large models we might get too many groups and it is not particularly useful"
]
