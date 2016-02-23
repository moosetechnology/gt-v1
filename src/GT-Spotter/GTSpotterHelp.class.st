"
A helper class containing the help for GT Spotter.
"
Class {
	#name : #GTSpotterHelp,
	#superclass : #CustomHelp,
	#category : #'GT-Spotter-Help'
}

{ #category : #documentation }
GTSpotterHelp class >> basicExamples [
	^ HelpTopic 
		title: 'Basic Examples'
		contents: 
'There are many things to search for using Spotter. Here are some basic examples to get started.

Searching for the GTSpotter class:
	GTSpotterMorph
	
Searching for a GT-Spotter package:
	GT-Spotter
	
Searching for a menu item:
	Monticello Browser

Searching for implementors of the #do: message:
	do:
	
Searching for a published playground page:
	http://ws.stfx.eu/G5LPL4Z68MJU
'
]

{ #category : #accessing }
GTSpotterHelp class >> bookName [ 
	^'GT Spotter'
]

{ #category : #documentation }
GTSpotterHelp class >> categoryFilterExamples [
	^ HelpTopic 
		title: 'Category Filter Examples'
		contents: 
'By default, Spotter searches for multiple things at the same time through search processors. Each of the processor offers the results in a separate category. For a list of all categories see the extensions help item.

While this is useful to discover different alternatives, when we know what we are looking for, we want to narrow the search for only one processor.

Let''s take an example. Suppose we want to search for packages related to Spotter. We start by searching for:
	spotter

The first item in the list is the Spotter item from the #Menu search category. This is certainly not what we are looking for. The next category shows us #Classes. This is again not what we are interested in. And then lower down the list, we see the #Packages category. That is what we are after.

One option is to navigate to that category. Another option is to scope the search to only show that category:
	spotter #packages

Now we get only the packages because # introduces a special search that matches the name of the category instead of the name of the item. In fact, to get the same result it is enough to say:
	spotter #pa

... because #Packages is the only top search category that begins with #pa.

This search scoping mechanism can be used for any category available in the current search step.

A less obvious situation happens when we have category names that contain a space. For example, in the top search we have:
- #Playground cached pages
- #Playground stashed pages

In this situation, it is possible to specify the scoping by ignoring the whitespace. For example:
	#playgroundcached
	#playgroundcachedpa
	#playgroundst
	#playgrounds'
]

{ #category : #documentation }
GTSpotterHelp class >> diveInCategoryExamples [
	^ HelpTopic 
		title: 'Dive-in Category Examples'
		contents:
'Dive-in (Meta+ArrowRight) allows you to go inside one element. Dive-in-category allows you to refine the search for the current category.

Let''s look at an example.

Suppose you want to search for all classes that have both Spotter and Morph in their names. Essentially, this is a search that involves two queries connected through an logical AND operation. 

So, you first search for:
	Spotter #classes

Then you dive-in category (Meta+Shift+ArrowRight, or click on the arrow button next to #Classes category name). This will get you in another step that contains only the elements from the collection. Then you refine the search:
	Morph
	
... and you get the classes that have both Spotter and Morph in their name. 
'
]

{ #category : #documentation }
GTSpotterHelp class >> diveInExamples [
	^ HelpTopic 
		title: 'Dive-in Examples'
		contents: 
'Spotter allows you to navigate and search through nested objects.

Let''s see an example.

Suppose we want to see all Spotter extensions from the Behavior class. We know that an extension is marked with the #spotterOrder: pragma. So, we first look for the pragma:
	spotterOrder: #pragma
	
We find our pragma. Then we dive-in it through Meta+ArrowRight (or clicking on the arrow button). This gets us inside a PragmaType object and provides several search possibilities relevant for only this object. Note how the breadbrumb from on top of the search input box shows us two steps: Spotter and spotterOrder:. The first category give us the concrete usages of the pragma. As we are interested in only Behavior, we type:
	Behavior

We then ensure that the preview is open (Meta+p), and we can browse the methods from Behavior that are the #spotterOrder: pragma.

The dive-in activity is useful when the search involves multiple steps.'
]

{ #category : #documentation }
GTSpotterHelp class >> extensionExamples [

	^ HelpTopic 
		title: 'Extending Spotter with custom search processors'
		contents:
''
]

{ #category : #documentation }
GTSpotterHelp class >> extensions [
		
	^ HelpTopic 
		title: 'Extensions installed in the image'
		contents: 'Spotter allows the developer to define custom search processors in different classes. These custom processors take effect when Spotter reaches an instance of the extended class. You can find below the complete list of extensions from this image.

The list is computed automatically. You can also browse it by inspecting:

		GTSpotter spotterExtendingMethods

', self extensionsString
]

{ #category : #documentation }
GTSpotterHelp class >> extensionsString [
	| methods title |
	^ String streamContents: [ :s |
		((GTSpotter spotterExtendingMethods groupedBy: #methodClass) 
		associations sorted: [ :a :b | a key name < b key name ]) 
		do: [ :classMethodsAssociation |
			s nextPutAll: classMethodsAssociation key name; cr.
			methods := classMethodsAssociation value.
			methods do: [ :each | 
				title := each ast allChildren 
					detect: [ :node | node isMessage and: [ node selector = #title: ] ]
					ifFound: [ :node | node arguments first value. ]
					ifNone: [ each selector ].
				title isString ifFalse: [ title := each selector ].
				s 
					nextPutAll: '- #'; 
					nextPutAll: title; 
					nextPutAll: ' (in '; 
					nextPutAll: each selector; 
					nextPut: $);
					cr ].
			s cr ] ]
]

{ #category : #accessing }
GTSpotterHelp class >> key [
	^ self name
]

{ #category : #documentation }
GTSpotterHelp class >> keybindings [
	^ HelpTopic 
		title: 'Keybindings'
		contents: 
'Cmd+p - open/close the preview pane

Cmd+w / Esc - close Spotter

Up / Down - navigate through the search result list

Cmd+Shift+Up/Down - navigate through the search categories

Enter - triggers the default action on the selected object

Cmd+Right - dive in an object

Cmd+Left / Cmd+Shift+Left - dive out from an object into the previous step

Cmd+Shift+Right - dive in a category to see its elements'
]

{ #category : #documentation }
GTSpotterHelp class >> overview [
	^ HelpTopic 
		title: 'Overview'
		contents: 
'GT Spotter is a moldable object search tool that is part of Pharo and was developed as part of the Glamorous Toolkit project (http://gt.moosetechnology.org).

Its goal is to help developers find and navigate through all sorts of objects, including packages, classes, methods, code snippets, or menus.'
]

{ #category : #accessing }
GTSpotterHelp class >> pages [
	^#(overview keybindings basicExamples categoryFilterExamples diveInExamples diveInCategoryExamples extensions)
]
