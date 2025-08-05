# Contribuindo para o Azure Arc HomeLab

Obrigado por considerar contribuir para este projeto! 🎉

## Como Contribuir

### 1. Reportar Issues
- Use o template de issue apropriado
- Inclua informações detalhadas sobre o problema
- Adicione logs ou screenshots quando aplicável

### 2. Sugerir Melhorias
- Abra uma issue com a tag "enhancement"
- Descreva claramente a melhoria proposta
- Explique como ela beneficiaria o projeto

### 3. Contribuir com Código

#### Processo
1. Fork do repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Faça commit das mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

#### Guidelines de Código

##### Scripts PowerShell
- Use `Write-Log` para logging consistente
- Inclua tratamento de erros com try/catch
- Documente parâmetros com comentários
- Teste em Windows Server 2019+ e Windows 10/11

##### Scripts Bash
- Use a função `log()` para mensagens
- Inclua verificação de distribuição Linux
- Teste em Ubuntu, CentOS/RHEL e SUSE
- Use shellcheck para validação

##### Documentação
- Mantenha README.md atualizado
- Use markdown lint para formatação
- Inclua exemplos práticos
- Traduza para português quando possível

#### Estrutura de Commits
```
tipo(escopo): descrição

Descrição mais detalhada se necessário

Fixes #123
```

Tipos aceitos:
- `feat`: nova funcionalidade
- `fix`: correção de bug
- `docs`: documentação
- `style`: formatação
- `refactor`: refatoração
- `test`: testes
- `chore`: manutenção

### 4. Revisão de Código

#### Checklist para PRs
- [ ] Código testado em ambiente similar ao HomeLab
- [ ] Documentação atualizada
- [ ] Sem credenciais hardcoded
- [ ] Scripts funcionam nos SOs suportados
- [ ] Markdown lint passou
- [ ] Changelog atualizado (se aplicável)

#### Critérios de Aprovação
- Dois approvals são necessários
- Todos os checks automatizados devem passar
- Sem conflitos de merge

## Segurança

### Informações Sensíveis
⚠️ **NUNCA** commite:
- Client secrets
- Service principal credentials
- Chaves de API
- Senhas ou tokens
- Informações de infraestrutura específica

### Reportar Vulnerabilidades
Para questões de segurança, envie email para [security@yourproject.com] ao invés de abrir issue pública.

## Código de Conduta

### Nossos Padrões
- Seja respeitoso e inclusivo
- Aceite críticas construtivas
- Foque no que é melhor para a comunidade
- Demonstre empatia com outros membros

### Comportamento Inaceitável
- Linguagem ou imagens ofensivas
- Ataques pessoais ou políticos
- Assédio público ou privado
- Qualquer forma de discriminação

## Suporte

- 📖 Consulte a [documentação](./docs/)
- 💬 Abra uma [discussion](../../discussions) para perguntas
- 🐛 Reporte bugs via [issues](../../issues)
- 📧 Entre em contato para questões específicas

## Reconhecimento

Contribuidores serão listados no README.md e releases notes.

---

Obrigado por contribuir! 🚀
