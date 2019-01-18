/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */
/*
 * The origin of this IDL file is:
 * https://dom.spec.whatwg.org/#interface-document
 * https://html.spec.whatwg.org/multipage/#the-document-object
 */

// https://dom.spec.whatwg.org/#interface-document
[Constructor]
interface Document : Node {
  [SameObject]
  readonly attribute DOMImplementation implementation;
  [Constant]
  readonly attribute USVString URL;
  [Constant]
  readonly attribute USVString documentURI;
  // readonly attribute USVString origin;
  readonly attribute DOMString compatMode;
  readonly attribute DOMString characterSet;
  readonly attribute DOMString charset; // legacy alias of .characterSet
  readonly attribute DOMString inputEncoding; // legacy alias of .characterSet
  [Constant]
  readonly attribute DOMString contentType;

  [Pure]
  readonly attribute DocumentType? doctype;
  [Pure]
  readonly attribute Element? documentElement;
  HTMLCollection getElementsByTagName(DOMString qualifiedName);
  HTMLCollection getElementsByTagNameNS(DOMString? namespace, DOMString qualifiedName);
  HTMLCollection getElementsByClassName(DOMString classNames);

  [CEReactions, NewObject, Throws]
  Element createElement(DOMString localName, optional ElementCreationOptions options);
  [CEReactions, NewObject, Throws]
  Element createElementNS(DOMString? namespace, DOMString qualifiedName, optional ElementCreationOptions options);
  [NewObject]
  DocumentFragment createDocumentFragment();
  [NewObject]
  Text createTextNode(DOMString data);
  [NewObject, Throws]
  CDATASection createCDATASection(DOMString data);
  [NewObject]
  Comment createComment(DOMString data);
  [NewObject, Throws]
  ProcessingInstruction createProcessingInstruction(DOMString target, DOMString data);

  [CEReactions, NewObject, Throws]
  Node importNode(Node node, optional boolean deep = false);
  [CEReactions, Throws]
  Node adoptNode(Node node);

  [NewObject, Throws]
  Attr createAttribute(DOMString localName);
  [NewObject, Throws]
  Attr createAttributeNS(DOMString? namespace, DOMString qualifiedName);

  [NewObject, Throws]
  Event createEvent(DOMString interface_);

  [NewObject]
  Range createRange();

  // NodeFilter.SHOW_ALL = 0xFFFFFFFF
  [NewObject]
  NodeIterator createNodeIterator(Node root, optional unsigned long whatToShow = 0xFFFFFFFF,
                                  optional NodeFilter? filter = null);
  [NewObject]
  TreeWalker createTreeWalker(Node root, optional unsigned long whatToShow = 0xFFFFFFFF,
                              optional NodeFilter? filter = null);
};

Document implements NonElementParentNode;
Document implements ParentNode;

enum DocumentReadyState { "loading", "interactive", "complete" };

dictionary ElementCreationOptions {
  DOMString is;
};

// https://html.spec.whatwg.org/multipage/#the-document-object
// [OverrideBuiltins]
partial /*sealed*/ interface Document {
  // resource metadata management
  [PutForwards=href, Unforgeable]
  readonly attribute Location? location;
  [SetterThrows] attribute DOMString domain;
  readonly attribute DOMString referrer;
  [Throws]
  attribute DOMString cookie;
  readonly attribute DOMString lastModified;
  readonly attribute DocumentReadyState readyState;

  // DOM tree accessors
     getter object (DOMString name);
  [CEReactions]
           attribute DOMString title;
  // [CEReactions]
  //       attribute DOMString dir;
  [CEReactions, SetterThrows]
           attribute HTMLElement? body;
  readonly attribute HTMLHeadElement? head;
  [SameObject]
  readonly attribute HTMLCollection images;
  [SameObject]
  readonly attribute HTMLCollection embeds;
  [SameObject]
  readonly attribute HTMLCollection plugins;
  [SameObject]
  readonly attribute HTMLCollection links;
  [SameObject]
  readonly attribute HTMLCollection forms;
  [SameObject]
  readonly attribute HTMLCollection scripts;
  NodeList getElementsByName(DOMString elementName);
  readonly attribute HTMLScriptElement? currentScript;

  // dynamic markup insertion
  [CEReactions, Throws]
  Document open(optional DOMString unused1, optional DOMString unused2);
  [CEReactions, Throws]
  WindowProxy open(DOMString url, DOMString name, DOMString features);
  [CEReactions, Throws]
  void close();
  [CEReactions, Throws]
  void write(DOMString... text);
  [CEReactions, Throws]
  void writeln(DOMString... text);

  // user interaction
  readonly attribute Window?/*Proxy?*/ defaultView;
  boolean hasFocus();
  // [CEReactions]
  // attribute DOMString designMode;
  // [CEReactions]
  // boolean execCommand(DOMString commandId, optional boolean showUI = false, optional DOMString value = "");
  // boolean queryCommandEnabled(DOMString commandId);
  // boolean queryCommandIndeterm(DOMString commandId);
  // boolean queryCommandState(DOMString commandId);
  // boolean queryCommandSupported(DOMString commandId);
  // DOMString queryCommandValue(DOMString commandId);

  // special event handler IDL attributes that only apply to Document objects
  [LenientThis] attribute EventHandler onreadystatechange;

  // also has obsolete members
};
Document implements GlobalEventHandlers;
Document implements DocumentAndElementEventHandlers;

// https://html.spec.whatwg.org/multipage/#Document-partial
partial interface Document {
  [CEReactions]
  attribute [TreatNullAs=EmptyString] DOMString fgColor;

  // https://github.com/servo/servo/issues/8715
  // [CEReactions, TreatNullAs=EmptyString]
  // attribute DOMString linkColor;

  // https://github.com/servo/servo/issues/8716
  // [CEReactions, TreatNullAs=EmptyString]
  // attribute DOMString vlinkColor;

  // https://github.com/servo/servo/issues/8717
  // [CEReactions, TreatNullAs=EmptyString]
  // attribute DOMString alinkColor;

  [CEReactions]
  attribute [TreatNullAs=EmptyString] DOMString bgColor;

  [SameObject]
  readonly attribute HTMLCollection anchors;

  [SameObject]
  readonly attribute HTMLCollection applets;

  void clear();
  void captureEvents();
  void releaseEvents();

  // Tracking issue for document.all: https://github.com/servo/servo/issues/7396
  // readonly attribute HTMLAllCollection all;
};

// http://w3c.github.io/touch-events/#idl-def-Document
partial interface Document {
      Touch createTouch(Window/*Proxy*/ view,
                        EventTarget target,
                        long identifier,
                        double pageX,
                        double pageY,
                        double screenX,
                        double screenY);

      TouchList createTouchList(Touch... touches);
};

// https://fullscreen.spec.whatwg.org/#api
partial interface Document {
  [LenientSetter] readonly attribute boolean fullscreenEnabled;
  [LenientSetter] readonly attribute Element? fullscreenElement;
  [LenientSetter] readonly attribute boolean fullscreen; // historical

  Promise<void> exitFullscreen();

  attribute EventHandler onfullscreenchange;
  attribute EventHandler onfullscreenerror;
};

Document implements DocumentOrShadowRoot;
