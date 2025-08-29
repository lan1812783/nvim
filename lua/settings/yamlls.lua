return {
  settings = {
    yaml = {
      customTags = {
        '!reference sequence', -- https://docs.gitlab.com/ee/ci/yaml/yaml_optimization.html#configure-your-ide-to-support-reference-tags
        -- CloudFormation custom tags (https://github.com/redhat-developer/vscode-yaml/issues/669#issuecomment-1136338006)
        '!Base64 scalar',
        '!Cidr scalar',
        '!And sequence',
        '!Equals sequence',
        '!If sequence',
        '!Not sequence',
        '!Or sequence',
        '!Condition scalar',
        '!FindInMap sequence',
        '!GetAtt scalar',
        '!GetAtt sequence',
        '!GetAZs scalar',
        '!ImportValue scalar',
        '!Join sequence',
        '!Select sequence',
        '!Split sequence',
        '!Sub scalar',
        '!Transform mapping',
        '!Ref scalar',
      },
    },
  },
}
