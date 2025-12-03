import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ApiTags, ApiOperation } from '@nestjs/swagger';

@ApiTags('Hello')
@Controller('/hello')
export class AppController {
    constructor(private readonly appservice: AppService) {}

    @Get()
    @ApiOperation({ summary: 'Hello world endpoint' })
    getHello(): string {
        return this.appservice.getHello();
    }
}
