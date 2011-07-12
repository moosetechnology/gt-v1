Class {
	#name : #GTTraitBrowser,
	#superclass : #Object,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #'initialize-release' }
GTTraitBrowser class >> open [
	^ self new open
]

{ #category : #building }
GTTraitBrowser >> allMethodsIn: constructor [
	constructor title: 'all methods'.
	^ constructor list
		display: [:classOrTrait | classOrTrait allSelectors];
		tags: [:selector :classOrTrait |
					(classOrTrait includesLocalSelector: selector) 
						ifTrue: [{'local'}] ifFalse: [
					(classOrTrait includesSelector: selector)
								ifTrue: [{'trait'}] ifFalse: [
					{(classOrTrait whichClassIncludesSelector: selector) name}]]];
		sorted
	
]

{ #category : #'initialize-release' }
GTTraitBrowser >> buildBrowser [ 
	|browser|
	browser := GLMFinder new.
	browser fixedSizePanes: 2.
	browser show: [:a | 
		a custom: self innerBrowser].
	^ browser
]

{ #category : #building }
GTTraitBrowser >> hierarchyIn: constructor [
	constructor title: 'hierarchy'.
	^ constructor list
		whenKindOf: Class;
		display: [:class | class allSuperclasses]
]

{ #category : #building }
GTTraitBrowser >> innerBrowser [ 
	|stacker browser|
	browser := GLMTabulator new.
	browser row: #classortraitName; row: #navigator span: 20.
	
	"have to try a composite presentation or a dynamic one"
	stacker := GLMStacker new.
	stacker 
		aPane: #localMethods;
		aPane: #hierarchy;
		aPane: #traits;
		aPane: #allMethods.
		
	stacker transmit to: #localMethods;
			andShow: [:a | self localMethodsIn: a].
	stacker transmit to: #hierarchy;
			andShow: [:a | self hierarchyIn: a].
	stacker transmit to: #traits;
			andShow: [:a | self traitsIn: a].
	stacker transmit to: #allMethods;
			andShow: [:a | self allMethodsIn: a].
			
	stacker transmit from: #hierarchy; toOutsidePort: #selection.
	stacker transmit from: #traits; toOutsidePort: #selection.
	
	browser transmit to: #classortraitName; andShow: [:a | a label display: [:classortrait | classortrait name]].
	browser transmit to: #navigator; andShow: [:a | a custom: stacker].
	browser transmit from: #navigator; toOutsidePort: #selection.
	
	^ browser
]

{ #category : #building }
GTTraitBrowser >> localMethodsIn: constructor [
	constructor title: 'methods'.
	^ constructor list
		display: [:class | class localSelectors];
		sorted
	
]

{ #category : #'initialize-release' }
GTTraitBrowser >> open [
	self buildBrowser openOn: NSCollectionStream 
	
]

{ #category : #building }
GTTraitBrowser >> traitsIn: constructor [
	constructor title: 'traits'.
	^ constructor list
		when: #hasTraitComposition;
		display: #traits
]
