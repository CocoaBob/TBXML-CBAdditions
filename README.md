TBXML-CBAdditions
=================
Some additional helpers to simplify the XML parsing codes.

Compatibilities
======================
Developed with Xcode 5.0, ARC enabled.

Usage
======================
A XML example 
```xml
<TODOList>
	<list date="2013-09-21 18:28">
		<name>
			Shopping List
		</name>
		<item date="2013-09-21 18:28">
			Apple juice
		</item>
		<item date="2013-09-21 18:28">
			Whole-wheat bread
		</item>
		<item date="2013-09-21 18:28">
			Eggs
		</item>
	</list>
</TODOList>
```
Normal parsing codes with TBXML.
```Objective-C
TBXMLElement *listElement = [TBXML childElementNamed:@"list" parentElement:tbXML.rootXMLElement];
while (listElement) {
    NSString *listDate = [TBXML valueOfAttributeNamed:@"date" forElement:listElement];
    TBXMLElement *nameElement = [TBXML childElementNamed:@"name" parentElement:listElement];
    if (nameElement) {
        NSString *listName = [TBXML textForElement:nameElement];
    }
    TBXMLElement *itemElement = [TBXML childElementNamed:@"item" parentElement:listElement];
    while (itemElement) {
        NSString *itemDate = [TBXML valueOfAttributeNamed:@"date" forElement:itemElement];
        NSString *itemText = [TBXML textForElement:itemElement];
        itemElement = [TBXML nextSiblingNamed:@"item" searchFromElement:itemElement];
    }
    listElement = [TBXML nextSiblingNamed:@"list" searchFromElement:tbXML.rootXMLElement];
}
```
Simplified codes with CBAdditions, thanks to Objective-C Literals and Blocks.
```Objective-C
[TBXML handleElement:tbXML.rootXMLElement
            handlers:@{@"list":@{kHandler:listHandler}}
             context:NULL
                stop:NULL];
```
And of cause, we still have to implement all the details.
```Objective-C
TBXMLElementHandler listHandler = ^void (TBXMLElement *element, void *context, BOOL *stop) {
    NSString *listDate = [TBXML valueOfAttributeNamed:@"date" forElement:element];
    YourListClass *aList = [YourListClass new];
    [TBXML handleElement:element
                handlers:@{@"name":listNameHandler,
                           kAnyNode:listItemHandler}
                 context:(__bridge void *)aList
                    stop:NULL];
};

TBXMLElementHandler listItemHandler = ^void (TBXMLElement *element, void *context, BOOL *stop) {
    YourListClass *aList = (__bridge YourListClass *)context;
    YourItemClass *anItem = [YourItemClass new];
    anItem.date = [TBXML valueOfAttributeNamed:@"date" forElement:element];
    anItem.text = [TBXML textForElement:element];
    [aList addItem:anItem];
};

TBXMLElementHandler listNameHandler = ^void (TBXMLElement *element, void *context, BOOL *stop) {
    YourListClass *aList = (__bridge YourListClass *)context;
    aList.name = [TBXML textForElement:element];
};
```

Actually, you can omit ```kHandler``` if you only want to handle the node. Like ```@{@"list":@{kHandler:listHandler}}```, you can just use ```@{@"list":listHandler}``` instead.

In one of my projects, I have a more complicated situation like this:
```Objective-C
[TBXML handleElement:[self.xmlObj rootXMLElement]
            handlers:@{@"config":@{@"renderMode":@{kAnyNode:renderModeHandler},// All faces
                                   @"outputMode":@{@"format":outputModeHandler},// All output formats
                                   @"startpoint":startPointHandler},
                       @"content":@{@"crosspoints":@{kAnyNode:crossPointHandler},// All crosspoints
                                    @"routes":@{kAnyNode:routeHandler}},// All routes
                       @"special":@{@"plans":@{kAnyNode:planHandler}}}// All plans
             context:(__bridge void *)(newDocument)
                stop:NULL];
```

Performance
======================
As what I've tested, it's at least 15% slower than pure TBXML solutions.

License
======================
TBXML-CBAdditions is licensed under [MIT License](https://github.com/CocoaBob/TBXML-CBAdditions/blob/master/LICENSE).