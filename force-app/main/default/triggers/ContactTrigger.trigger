trigger ContactTrigger on Contact (before insert) {
        System.debug('Hola3');
}