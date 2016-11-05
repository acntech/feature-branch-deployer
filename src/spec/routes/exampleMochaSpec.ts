import * as request from 'supertest';
import app from './../../app';

 describe('Mocha: Example routes', () => {

  it('should get 200 response from message', done => {
    request(app)
      .get('/message')
      .expect(404, done);
  });

  it('should get 404 from unknown route', done => {
    request(app)
      .get('/asodkoasd9923942ik3koadskoaksda9isd')
      .expect(404, done);
  });


});
