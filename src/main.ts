import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    // Swagger config
    const config = new DocumentBuilder()
        .setTitle('Nest SynapsID')
        .setDescription('API documentation')
        .setVersion('1.0')
        .build();

    const document = SwaggerModule.createDocument(app, config);

    // Display Swagger di root path '/'
    SwaggerModule.setup('/', app, document);

    // Middleware request body validation
    app.useGlobalPipes(new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
        transformOptions: {
            enableImplicitConversion: true,
        },
    }));


    const port = process.env.PORT || 3000;
    await app.listen(port);

    console.log(`🚀 Application is running on: http://localhost:${port}`);
}
bootstrap();