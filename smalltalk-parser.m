// Filename - test-json-parser.c

#import <Foundation/Foundation.h>
#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <tree_sitter/api.h>

// Declare the `tree_sitter_json` function, which is
// implemented by the `tree-sitter-json` library.
TSLanguage *tree_sitter_smalltalk();

int main(int argc, char **argv) {
  // Create a parser.
  TSParser *parser = ts_parser_new();

  // Set the parser's language (Smalltalk in this case).

  ts_parser_set_language(parser, tree_sitter_smalltalk());
	NSLog(@"filename: '%s'",argv[1]);
	NSString *filename = @(argv[1]);
	NSLog(@"filename: '%@'",filename);
	NSString *source = [NSString stringWithContentsOfFile:@(argv[1])];	
	NSLog(@"file: '%@' contents: '%@'",filename,source);

  // Build a syntax tree based on source code stored in a string.
  const char *source_code = [source UTF8String];
  TSTree *tree = ts_parser_parse_string(
    parser,
    NULL,
    source_code,
    strlen(source_code)
  );

  // Get the root node of the syntax tree.
  TSNode root_node = ts_tree_root_node(tree);

  // Get some child nodes.
  TSNode array_node = ts_node_named_child(root_node, 0);
  TSNode number_node = ts_node_named_child(array_node, 0);


  // Print the syntax tree as an S-expression.
  char *string = ts_node_string(root_node);
  printf("Syntax tree: %s\n", string);

  // Free all of the heap-allocated memory.
  free(string);
  ts_tree_delete(tree);
  ts_parser_delete(parser);
  return 0;
}

