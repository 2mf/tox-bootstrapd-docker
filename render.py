#!/usr/bin/python3

import sys
import os
import argparse
import json
import collections
import requests

from jinja2 import Template

def render_template(template, env_dict, output):

    if template['type'] == 'url':
        try:
            f = requests.get(template['target'])
            f.raise_for_status()
        except requests.exceptions.RequestException as e:
            print("Failed to download template: %s" % e)
            sys.exit(1)
        template = f.text
    else:
        with open(template['target'], 'r') as f:
            template = f.read()

    result = Template(template).render(**env_dict)

    if output:
        with open(output, 'w') as fp:
            fp.write(result)
    else:
        print(result)


def is_valid_file(arg):
    """
    Argparse 'type' callback.
    Validate that the argument is an URL or the path to an existing file.
    """
    if arg.startswith('http://') or arg.startswith('https://'):
        return { 'type': 'url', 'target': arg }

    if os.path.isfile(arg):
        return { 'type': 'file', 'target': os.path.abspath(arg) }


if __name__ == '__main__':
    # Define arguments parser.
    parser = argparse.ArgumentParser(description='Helper to render a Jinja2.')
    parser.add_argument('TEMPLATE',
                        type=is_valid_file,
                        help='Path to the Jinja2 template file.')
    parser.add_argument('TEMPLATE_DATA',
                        type=is_valid_file,
                        help='URL to JSON data containing the data to be '
                             'filled in the template.')
    parser.add_argument('-e', '--env',
                        dest='env',
                        help='Comma-separated list of elements from environment variables to be used')

    parser.add_argument('-o', '--output',
                        dest='output',
                        metavar='FILE',
                        help='Output file')

    # Parse arguments.
    args=parser.parse_args()

    env_dict={}
    if args.env:
        env_dict.update([(key, os.getenv(key)) for key in args.env.split(',') if os.getenv(key)])

    if args.TEMPLATE_DATA['type'] == 'url':
        try:
            data = requests.get(args.TEMPLATE_DATA['target']).json()
        except Exception as e:
            print("Failed to download template: %s" % e)
            sys.exit(1)
    else:
        data = json.load(open(args.TEMPLATE_DATA['target']))

    env_dict['json_data'] = data
    # Render the template.
    render_template(args.TEMPLATE, env_dict, args.output)

