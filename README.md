# Log parser in ruby

## Running instructions

The parser was written using Ruby 3.1.1. The parser accepts a log file name as argument, I used the one provided - `logs/webserver.log`

To run the script: `./parser logs/webserver.log`

## Running tests

1. `bundle`
2. `rspec`

## Running rubocop

1. `bundle`
2. `rubocop`

# Thoughts

## Thinking process

The test description specified precisely the input of the script and what the script should produce (output).
Keeping that in mind I wrote an integration test (`spec/log_parser_spec.rb`) that does exactly what user would do:
execute script with a log as argument. Expectation was that the script will output results on the screen in a proper shape.

Generally, I wrote the code from the outside (input & output) to the inside (core of the parser).
I started coding from tests. I had a "Printer" module on my mind, so I wrote a test to make sure that the script output looks exactly as expected. Later on I created the code for the module that accepts parsing results, wrap them up with some text and finally output everything to stdout.

Input from a user should always be validated so I wrote some tests that cover cases of non-existing file and if the file has any content, after that I wrote the "Validator" module that uses smaller validator modules.

When "Printer" and "Validators" were ready, I decided on the parsed data shape and wrote a test for the core part `spec/log_parser/core_spec.rb`. The "Core" module was created at the end, to satisfy last tests.

When the code was ready, I added `rubocop` to be able to fix some issues. At the moment rubocop is not satisfied.

## Issues I encountered

- Due to the time limit I wasn't able to write the code that I'm really satisfied with. Even though it works, it requires more work.
- I was mostly focused on tests - I tried to have them precise and DRY. I think that consumed more time then expected.
- If I had more time, I'd be focused on the "Core" module which doesn't look good at the moment. We might have modules like builder and sorter there because the Core does too many things.
- Next place for improvements would be "Printer" - adding some minor modules and/or structures would make code look better.

## Script extension ideas

- Additional param for sorting direction (desc/asc)
- Additional param for limiting number of results (integer)
- Getting more information from the logs: most common IP addresses
- Accepting more log formats: maybe JSON logs?
- Using OptionParser ruby class to accept more script options and adding help
