// Code generated by sqlc. DO NOT EDIT.

package db

import (
	"context"
)

type Querier interface {
	CreateAccount(ctx context.Context, arg CreateAccountParams) (TbAlunos, error)
	CreateAdmin(ctx context.Context, arg CreateAdminParams) (TbAdmin, error)
	CreateCurso(ctx context.Context, arg CreateCursoParams) (TbCadastroCursos, error)
	DeleteAccount(ctx context.Context, idaluno int64) error
	DeleteAdmin(ctx context.Context, id int64) error
	DeleteCurso(ctx context.Context, idcurso int64) error
	GetAccount(ctx context.Context, idaluno int64) (TbAlunos, error)
	GetAdmin(ctx context.Context, id int64) (TbAdmin, error)
	GetCadastroCursos(ctx context.Context, idcurso int64) (TbCadastroCursos, error)
	ListAccounts(ctx context.Context, arg ListAccountsParams) ([]TbAlunos, error)
	ListAdmin(ctx context.Context) ([]TbAdmin, error)
	ListCursos(ctx context.Context) ([]TbCadastroCursos, error)
	UpdateAccount(ctx context.Context, arg UpdateAccountParams) (TbAlunos, error)
	UpdateAccountAdmin(ctx context.Context, arg UpdateAccountAdminParams) (TbAdmin, error)
}

var _ Querier = (*Queries)(nil)
