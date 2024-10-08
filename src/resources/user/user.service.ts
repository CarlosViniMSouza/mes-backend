import { CreateUserDto, UpdateUserDto, UserDto } from "./user.types";
import { genSalt, hash } from "bcryptjs";
import { PrismaClient, User } from "@prisma/client";

const prisma = new PrismaClient();

export const usedEmail = async (email: string): Promise<Boolean> => {
  return !!(await prisma.user.findFirst({ where: { email } }));
};

export const createUser = async (user: CreateUserDto): Promise<UserDto> => {
  const rounds = parseInt(process.env.BCRYPT_ROUNDS!);
  const salt = await genSalt(rounds);
  const senha = await hash(user.senha, salt);

  return await prisma.user.create({
    select: {
      id: true,
      nome: true,
      login: true,
      email: true,
      createdAt: true,
      updatedAt: true,
    },
    data: {
      ...user,
      senha,
    },
  });
};

export const listUsers = async (): Promise<UserDto[]> => {
  return await prisma.user.findMany({
    select: {
      id: true,
      nome: true,
      login: true,
      email: true,
      createdAt: true,
      updatedAt: true,
    },
  });
};

export const getUser = async (id: string): Promise<UserDto | null> => {
  return await prisma.user.findUnique({
    where: { id },
  });
};

export const updateUser = async (user: UpdateUserDto): Promise<User> => {
  return await prisma.user.update({
    data: user,
    where: {
      id: user.id,
    },
  });
};

export const removeUser = async (id: string): Promise<UserDto> => {
  return await prisma.user.delete({ where: { id } });
};

export const findLogin = async (login: string): Promise<UserDto[]> => {
  return await prisma.user.findMany({
    where: {
      login: {
        contains: login,
      },
    },
  });
};

export const findName = async (nome: string): Promise<UserDto[]> => {
  return await prisma.user.findMany({
    where: {
      nome: {
        contains: nome,
      },
    },
  });
};
