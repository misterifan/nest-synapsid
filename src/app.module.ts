import { Module } from '@nestjs/common';
import { AppService } from './app.service';
import { AppController } from './app.controller';
import { AuthenticationModule } from './authentication/authentication.module';
import { AuthorizationModule } from './authorization/authorization.module';
import { UsersModule } from './users/users.module';

@Module({
  providers: [AppService],
  controllers: [AppController],
  imports: [AuthenticationModule, AuthorizationModule, UsersModule]
})
export class AppModule {}
